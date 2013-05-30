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

namespace Plugins {

	// Scripting Plugin
	namespace Scripting {

		public class ScriptingTab { /* Base to scripting tabs */ }

		// The tab system plugin
		public class TabPlugin : Object, Tab {
			public void show(Gtk.Box container) {
				// Shows the plugin content
				//container.pack_start(content);
			}

			public void hide() {
				// Hides the plugin content without destroying it
			}

			// Saves the plugin session
			public void session_save() {
			}

			// Loads the plugin session
			public void session_load() {
			}


		}

	} // Scripting
} // Plugins
/*

namespace Tabs {
	public class SourceEditor : Object, Base {
		private Gtk.TreeView view;
		private Gtk.TreeStore model;
		private Gtk.Box sidebar = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
		private Gtk.Notebook editor = new Gtk.Notebook();
		private Gtk.Box content = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
		private Gtk.Box dashboard = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);

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

    private enum Columns {
        TOGGLE,
        TEXT,
        N_COLUMNS
    }

		private void setup_dashboard() {
			// Dashboard tab title
			Gtk.Label tab_title = new Gtk.Label("Dashboard");
			// Dashboard header
			Gtk.Box header = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 0);
			Gtk.Label title = new Gtk.Label("<span size=\"x-large\">Scripting Dashboard</span>");
			title.set_use_markup(true);
			// Header title and settings menu
			Gtk.MenuButton settings_button = new Gtk.MenuButton();
			Menu menumodel = new Menu();
			settings_button.image = new Gtk.Image.from_stock(Gtk.Stock.PREFERENCES, Gtk.IconSize.DND);
			settings_button.direction = Gtk.ArrowType.NONE;
			settings_button.always_show_image = true;
			menumodel.append("Import Settings", "");
			menumodel.append("Export Settings", "");
			menumodel.append("Clear Settings", "");
			menumodel.append("Default  Settings", "");
			settings_button.set_menu_model(menumodel);
			// Packing the header
			header.pack_start(title, false, true, 8);
			header.pack_end(settings_button, false, true, 8);
			// Custom `make' settings
			Gtk.Box make_settings = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 0);
			// Content Boxes
			Gtk.Frame packages = new Gtk.Frame ("Vala Packages:");
			(packages.label_widget as Gtk.Label).use_markup = true;
			Gtk.Frame valacflags = new Gtk.Frame ("Valac Flags:");
			(valacflags.label_widget as Gtk.Label).use_markup = true;
			Gtk.Frame makefile = new Gtk.Frame ("Generated Makefile:");
			(makefile.label_widget as Gtk.Label).use_markup = true;
			// Setup each part
      setup_package_list(packages);
      setup_custom_flags(valacflags);
      setup_makefile(makefile);
      // Packing the make settings
      make_settings.pack_start(packages,true,true,8);
      make_settings.pack_start(valacflags,true,true,8);
      make_settings.pack_start(makefile,true,true,8);
      // Packing the dashboard
			this.dashboard.pack_start(header, false, false,8);
			this.dashboard.pack_start(make_settings, true, true, 8);
			this.editor.append_page(this.dashboard, tab_title);
			// An extra debug tab
		}

		private void setup_package_list(Gtk.Frame frame) {
			Gtk.Box content = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
      Gtk.ListStore package_model = new Gtk.ListStore (Columns.N_COLUMNS, typeof (bool), typeof (string));
      Gtk.TreeView package_view = new Gtk.TreeView.with_model(package_model);
			Gtk.CellRendererToggle  toggle = new Gtk.CellRendererToggle();
			toggle.toggled.connect((toggle, path) => {
				Gtk.TreePath tree_path = new Gtk.TreePath.from_string(path);
				Gtk.TreeIter iter;
				package_model.get_iter(out iter, tree_path);
				package_model.set(iter, Columns.TOGGLE, !toggle.active);
			});
			Gtk.TreeViewColumn column = new Gtk.TreeViewColumn();
			column.pack_start(toggle, false);
			column.add_attribute(toggle, "active", Columns.TOGGLE);
			package_view.append_column(column);
			Gtk.CellRendererText text = new Gtk.CellRendererText();
			column = new Gtk.TreeViewColumn();
			column.pack_start(text, true);
			column.add_attribute(text, "text", Columns.TEXT);
			package_view.append_column(column);
			package_view.set_headers_visible(false);
			Gtk.TreeIter iter;
			package_model.append(out iter);
			package_model.set(iter, Columns.TOGGLE, true, Columns.TEXT, "item 1");
			package_model.append (out iter);
			package_model.set(iter, Columns.TOGGLE, false, Columns.TEXT, "item 2");
			// User entry
			Gtk.Box entry_box = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 0);
			Gtk.Entry entry = new Gtk.Entry();
			Gtk.Button entry_button = new Gtk.Button();
			entry_button.image = new Gtk.Image.from_stock(Gtk.Stock.ADD, Gtk.IconSize.MENU);
			entry_button.always_show_image = true;
			entry_box.pack_start(entry,true,true,0);
			entry_box.pack_end(entry_button,false,false,0);
      // Packing packages
      content.pack_start(package_view,true,true,0);
      content.pack_end(entry_box,false,false,0);
      frame.add(content);
		}

		private void setup_custom_flags(Gtk.Frame frame) {
			Gtk.Box content = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
      Gtk.ListStore package_model = new Gtk.ListStore (Columns.N_COLUMNS, typeof (bool), typeof (string));
      Gtk.TreeView package_view = new Gtk.TreeView.with_model(package_model);
			Gtk.CellRendererToggle  toggle = new Gtk.CellRendererToggle();
			toggle.toggled.connect((toggle, path) => {
				Gtk.TreePath tree_path = new Gtk.TreePath.from_string(path);
				Gtk.TreeIter iter;
				package_model.get_iter(out iter, tree_path);
				package_model.set(iter, Columns.TOGGLE, !toggle.active);
			});
			Gtk.TreeViewColumn column = new Gtk.TreeViewColumn();
			column.pack_start(toggle, false);
			column.add_attribute(toggle, "active", Columns.TOGGLE);
			package_view.append_column(column);
			Gtk.CellRendererText text = new Gtk.CellRendererText();
			column = new Gtk.TreeViewColumn();
			column.pack_start(text, true);
			column.add_attribute(text, "text", Columns.TEXT);
			package_view.append_column(column);
			package_view.set_headers_visible(false);
			Gtk.TreeIter iter;
			package_model.append(out iter);
			package_model.set(iter, Columns.TOGGLE, true, Columns.TEXT, "item 1");
			package_model.append (out iter);
			package_model.set(iter, Columns.TOGGLE, false, Columns.TEXT, "item 2");
			// User entry
			Gtk.Box entry_box = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 0);
			Gtk.Entry entry = new Gtk.Entry();
			Gtk.Button entry_button = new Gtk.Button();
			entry_button.image = new Gtk.Image.from_stock(Gtk.Stock.ADD, Gtk.IconSize.MENU);
			entry_button.always_show_image = true;
			entry_box.pack_start(entry,true,true,0);
			entry_box.pack_end(entry_button,false,false,0);
      // Packing packages
      content.pack_start(package_view,true,true,0);
      content.pack_end(entry_box,false,false,0);
      frame.add(content);
		}

		private void setup_makefile(Gtk.Frame frame) {
			Gtk.Box content = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
			Gtk.ScrolledWindow scroll = new Gtk.ScrolledWindow(null, null);
			Gtk.TextView text_view = new Gtk.TextView ();
			//text_view.editable = false;
			scroll.add(text_view);
      content.pack_start(scroll,true,true,0);
      frame.add(content);
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
			separator.pack_start(new Gtk.Label("Temporary Editor Configs"), false, false);
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
*/
} // Avalanche
