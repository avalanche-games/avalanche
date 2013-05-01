/*
 *  This Source Code Form is subject to the terms of the Mozilla Public
 *  License, v. 2.0. If a copy of the MPL was not distributed with this
 *  file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 *                          Copyright(C) 2013
 *                   Christian Ferraz Lemos de Sousa
 *                      Pedro Henrique Lara Campos
 *
 * TODO: Finish the search dialog
 *       Save and Load scripts
 *
 * Note: This source still needs a partial rewrite to act more efficiently
 */
namespace Avalanche {

namespace Tabs {
	public class SourceEditor : Object, Base {
		private Gtk.TreeView view;
		private Gtk.TreeStore model;
		private Gtk.Box sidebar = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
		private Gtk.Notebook editor = new Gtk.Notebook();
		private Gtk.Box content = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);

		public SourceEditor() {
			// Listing and tabs division
			Gtk.Paned division = new Gtk.Paned(Gtk.Orientation.HORIZONTAL);
			division.position_set = true;
			division.position = 100;
			// Setup editor
			setup_sidebar();
			setup_dashboard();
			// Content packing
			division.pack1(this.sidebar, true, true);
			division.pack2(this.editor, true, true);
			content.pack_start(division, true, true);
		}

		~SourceEditor() {
			// Destructor
			this.content.destroy();
		}

		public void show_at(Gtk.Box container) {
			container.pack_start(content);
		}

		private void setup_sidebar() {
			// Script listing
			this.model = new Gtk.TreeStore(2, typeof(string), typeof(Gdk.Pixbuf));
			this.view = setup_script_list(this.model);
			// Containers
			Gtk.Frame frame = new Gtk.Frame(null);
			Gtk.ScrolledWindow scripts  = new Gtk.ScrolledWindow(null, null);
			Gtk.Box footer     = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 0);
			Gtk.Box add_remove = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 0);
			// Container configs
			scripts.add(this.view);
			frame.add(scripts);
			// Action buttons
			Gtk.Button new_btn    = new Gtk.Button();
			Gtk.Button delete_btn = new Gtk.Button();
			Gtk.Button search_btn = new Gtk.Button();
			// Buttom images
			Gtk.Image new_img    = new Gtk.Image.from_stock(Gtk.Stock.NEW, Gtk.IconSize.MENU);
			Gtk.Image delete_img = new Gtk.Image.from_stock(Gtk.Stock.DELETE, Gtk.IconSize.MENU);
			Gtk.Image search_img = new Gtk.Image.from_stock(Gtk.Stock.FIND, Gtk.IconSize.MENU);
			// Buttom text
			new_btn.label = "New";
			new_btn.set_tooltip_text("New Script");
			delete_btn.set_tooltip_text("Delete Script");
			search_btn.set_tooltip_text("Search Dialog");
			// Force images
			new_btn.image = new_img;
			delete_btn.image = delete_img;
			search_btn.image = search_img;
			new_btn.always_show_image = true;
			delete_btn.always_show_image = true;
			search_btn.always_show_image = true;
			// Adding buttons
			add_remove.pack_start( new_btn, false, false);
			add_remove.pack_start(delete_btn, false, false);
			footer.pack_start(add_remove, true, true);
			footer.pack_end(search_btn,false, false);
			// Adding sidebar
			this.sidebar.pack_start(footer, false, false, 0);
			this.sidebar.pack_end(frame, true, true, 0);
		}

		private Gtk.TreeView setup_script_list(Gtk.TreeStore store) {
			Gtk.TreeView view = new Gtk.TreeView.with_model(store);
			view.set_headers_visible(false);
			view.insert_column_with_attributes(-1, "Icon", new Gtk.CellRendererPixbuf(), "pixbuf", 1, null);
			view.insert_column_with_attributes(-1, "Name", new Gtk.CellRendererText(), "text", 0, null);
			list_directory(store);
			return(view);
		}

		private void setup_dashboard() {
			// Dashboard
			this.editor.append_page(new Gtk.Label("This will be the dashboard..."), new Gtk.Label("Dashboard"));
			File file = File.new_for_path(Environment.get_home_dir() + "/.local/share/Avalanche/DebugProject/src/" +
			                              "sample-script.vala");
			setup_new_editor(file);
		}

		private void setup_new_editor(File file) {
			Gtk.Box separator = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
			Gtk.ScrolledWindow scroll = new Gtk.ScrolledWindow(null, null);
			Gtk.SourceView view = new Gtk.SourceView();
			Gtk.SourceBuffer buffer = new Gtk.SourceBuffer.with_language(Gtk.SourceLanguageManager.get_default
			                                                             ().get_language("vala"));
			// Editor default settings
			buffer.style_scheme = Miscellaneuous.get_syntax_style();
			view.buffer = buffer;
			view.right_margin_position = 120;
			view.set_show_right_margin(true);
			view.set_show_line_numbers(true);
			view.set_show_line_marks(true);
			view.set_highlight_current_line(true);
			view.set_indent_width(4);
			view.set_tab_width(4);
			view.set_indent_on_tab(true);
			view.set_auto_indent(true);
			view.set_insert_spaces_instead_of_tabs(false);
			view.override_font(Pango.FontDescription.from_string("Liberation Mono 11"));
			view.draw_spaces = (Gtk.SourceDrawSpacesFlags.SPACE + Gtk.SourceDrawSpacesFlags.TAB +
			                           Gtk.SourceDrawSpacesFlags.TRAILING + Gtk.SourceDrawSpacesFlags.NEWLINE);
			// Adding the editor
			scroll.set_policy(Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.AUTOMATIC);
			scroll.add(view);
			separator.pack_start(scroll, true, true);
			separator.pack_start(new Gtk.Label("Potados"), false, false);
			this.editor.append_page(separator);
		}

		private async void list_directory(Gtk.TreeStore store){
			string path = (Environment.get_home_dir() + "/.local/share/Avalanche/DebugProject/src/");
			var dir = File.new_for_path(path);
			try {
				// Asynchronous call, get directory entries
				var e = yield dir.enumerate_children_async(FileAttribute.STANDARD_NAME, 0, Priority.DEFAULT);
				Gtk.TreeIter root;
				while(true) {
					// Asynchronous call, get entries
					var files = yield e.next_files_async(10, Priority.DEFAULT);
					if(files == null){
						break;
					}
					// append the files found so far to the list
					foreach(var info in files){
						switch (info.get_file_type()) {
						case FileType.DIRECTORY:
							store.append(out root, null);
							store.set(root, 1, new Gdk.Pixbuf.from_file("/usr/lib/avalanche/icons/folder.png"), 0,
							                                            info.get_name(), -1);
							list_subdir(store, root, (path+info.get_name()));
							break;
						case FileType.REGULAR:
							store.append(out root, null);
							store.set(root, 1, new Gdk.Pixbuf.from_file("/usr/lib/avalanche/icons/vala.png"), 0,
							                                            info.get_name(), -1);
							break;
						}
					}
				}
			}catch (Error err) {
				stderr.printf("Error: SourceEditor list_directory failed: %s\n", err.message);
			}
		}

		private async void list_subdir(Gtk.TreeStore store, Gtk.TreeIter root, string path) {
			var dir = File.new_for_path(path);
			try {
				// Asynchronous call, get directory entries
				var e = yield dir.enumerate_children_async(FileAttribute.STANDARD_NAME, 0, Priority.DEFAULT);
				Gtk.TreeIter category_iter;
				while(true) {
					// Asynchronous call, get entries
					var files = yield e.next_files_async(10, Priority.DEFAULT);
					if(files == null){
						break;
					}
					// Append the files found so far to the list
					foreach(var info in files){
						switch(info.get_file_type()) {
						case FileType.DIRECTORY:
							store.append(out category_iter, root);
							store.set(category_iter, 1, new Gdk.Pixbuf.from_file
							          ("/usr/lib/avalanche/icons/folder.png"), 0, info.get_name(), -1);
							list_subdir(store, root, (path+info.get_name()));
							break;
						case FileType.REGULAR:
							store.append(out category_iter, root);
							store.set(category_iter, 1, new Gdk.Pixbuf.from_file("/usr/lib/avalanche/icons/vala.png"),
							          0, info.get_name(), -1);
							break;
						}
					}
				}
			}catch(Error err) {
				stderr.printf("Error: SourceEditor list_subdir failed: %s\n", err.message);
			}
		}
	}
} // Tabs

} // Avalanche
