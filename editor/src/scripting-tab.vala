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

		// The tab system plugin
		public class TabPlugin : Object, Tab {

			private Gtk.TreeView view;
			private Gtk.TreeStore model;
			private Gtk.Box sidebar = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
			private Gtk.Notebook editor = new Gtk.Notebook();
			private Gtk.Box content = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
			private Gtk.Box dashboard = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);

			public void show(Gtk.Notebook notebook) {
				notebook.append_page(this.content, new Gtk.Label("Scripting"));
				this.content.show_all();
			}

			public void hide() {
				// Hides the plugin content without destroying it
			}

			public void create_menu() {
				// Creates a new menu
			}

			// Saves the plugin session
			public void session_save() {
			}

			// Loads the plugin session
			public void session_load() {
			}

			public TabPlugin() {
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
				this.content.pack_start(division, true, true);
			}

			~TabPlugin() {
				this.content.destroy();
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
				Gtk.Box master_box = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 0);
				Gtk.Box make_settings = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
				Gtk.Box make_build = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);

				// Content Boxes
				/*
				Gtk.Frame makefile = new Gtk.Frame ("Generated Makefile:");
				(makefile.label_widget as Gtk.Label).use_markup = true;*/
				// Setup each part
				setup_package_list(make_settings);
				setup_custom_flags(make_settings);
				setup_make_zone(make_build);

				// Packing the make settings
				//make_settings.pack_start(packages,true,true,8);
				//make_settings.pack_start(valacflags,true,true,8);
				master_box.pack_start(make_settings,true,true,8);
				master_box.pack_start(make_build,true,true,8);
				//make_box.pack_start(makefile,true,true,8);

				// Packing the dashboard
				this.dashboard.pack_start(header, false, false,8);
				this.dashboard.pack_start(master_box, true, true, 8);
				this.editor.append_page(this.dashboard, tab_title);
			}

			private void setup_package_list(Gtk.Box box) {
				// This box will hold the tree view and entry
				Gtk.Box package_box = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
				// The frame will wrap the tree view
				Gtk.Frame packages = new Gtk.Frame ("Packages and/or Libraries:");
				(packages.label_widget as Gtk.Label).use_markup = true;
				// Package list listing system (might get things from project class)
				Gtk.ListStore package_model = new Gtk.ListStore (Columns.N_COLUMNS, typeof (bool), typeof (string));
				Gtk.TreeView package_view = new Gtk.TreeView.with_model(package_model);
				prepare_generic_make_list(package_model, package_view);
				// Adding itens to the list
				Gtk.TreeIter iter;
				package_model.append(out iter);
				package_model.set(iter, Columns.TOGGLE, true, Columns.TEXT, "item 1");
				package_model.append (out iter);
				package_model.set(iter, Columns.TOGGLE, false, Columns.TEXT, "item 2");
				// User entry system
				Gtk.Box entry_box = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 0);
				Gtk.Entry entry = new Gtk.Entry();
				// Creating buttons
				Gtk.Button add_entry    = new Gtk.Button();
				Gtk.Button delete_entry = new Gtk.Button();
				// Setting button images
				add_entry.image    = new Gtk.Image.from_stock(Gtk.Stock.ADD, Gtk.IconSize.MENU);
				delete_entry.image = new Gtk.Image.from_stock(Gtk.Stock.DELETE, Gtk.IconSize.MENU);
				// Button settings
				add_entry.always_show_image = true;
				delete_entry.always_show_image = true;
				add_entry.set_tooltip_text("Add Package");
				delete_entry.set_tooltip_text("Remove Package");
				// Packing buttons
				entry_box.pack_start(entry,true,true,0);
				entry_box.pack_end(delete_entry,false,false,2);
				entry_box.pack_end(add_entry,false,false,2);
				// Packing up stuff
				packages.add(package_view);
				package_box.pack_start(packages, true, true, 0);
				package_box.pack_start(entry_box, false, false, 2);
				box.pack_start(package_box, true, true, 0);
			}

			private void setup_custom_flags(Gtk.Box box) {
				// This box will hold the tree view and entry
				Gtk.Box package_box = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
				// The frame will wrap the tree view
				Gtk.Frame packages = new Gtk.Frame ("Compiler Flags:");
				(packages.label_widget as Gtk.Label).use_markup = true;
				// Package list listing system (might get things from project class)
				Gtk.ListStore package_model = new Gtk.ListStore (Columns.N_COLUMNS, typeof (bool), typeof (string));
				Gtk.TreeView package_view = new Gtk.TreeView.with_model(package_model);
				prepare_generic_make_list(package_model, package_view);
				// Adding itens to the list
				Gtk.TreeIter iter;
				package_model.append(out iter);
				package_model.set(iter, Columns.TOGGLE, true, Columns.TEXT, "item 1");
				package_model.append (out iter);
				package_model.set(iter, Columns.TOGGLE, false, Columns.TEXT, "item 2");
				// User entry system
				Gtk.Box entry_box = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 0);
				Gtk.Entry entry = new Gtk.Entry();
				// Creating buttons
				Gtk.Button add_entry    = new Gtk.Button();
				Gtk.Button delete_entry = new Gtk.Button();
				// Setting button images
				add_entry.image    = new Gtk.Image.from_stock(Gtk.Stock.ADD, Gtk.IconSize.MENU);
				delete_entry.image = new Gtk.Image.from_stock(Gtk.Stock.DELETE, Gtk.IconSize.MENU);
				// Button settings
				add_entry.always_show_image = true;
				delete_entry.always_show_image = true;
				add_entry.set_tooltip_text("Add Package");
				delete_entry.set_tooltip_text("Remove Package");
				// Packing buttons
				entry_box.pack_start(entry,true,true,0);
				entry_box.pack_end(delete_entry,false,false,2);
				entry_box.pack_end(add_entry,false,false,2);
				// Packing up stuff
				packages.add(package_view);
				package_box.pack_start(packages, true, true, 0);
				package_box.pack_start(entry_box, false, false, 2);
				box.pack_start(package_box, true, true, 0);
			}

			private void prepare_generic_make_list(Gtk.ListStore package_model, Gtk.TreeView package_view) {
				// Boilerplate :(
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
			}

			private void setup_make_zone(Gtk.Box box) {
				// This box will hold the preview and the output
				Gtk.Box makefile_master = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
				// this box will hold the preview, a label and an build command
				Gtk.Box makefile_preview = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
				// The frame will wrap the scrolled window
				Gtk.Frame makefile = new Gtk.Frame ("Makefile Preview:");
				(makefile.label_widget as Gtk.Label).use_markup = true;
				// Scrolled window will wrap the text view
				Gtk.ScrolledWindow makefile_scroll = new Gtk.ScrolledWindow(null, null);
				Gtk.TextView makefile_view = new Gtk.TextView ();
				// Tes, you can modify the makefile at runtime :D
				makefile_view.editable = true;
				makefile_scroll.add(makefile_view);
				makefile.add(makefile_scroll);
				// The frame will wrap the terminal window
				Gtk.Frame terminal = new Gtk.Frame ("Makefile Preview:");
				(terminal.label_widget as Gtk.Label).use_markup = true;
				// Terminal Output
				Gtk.ScrolledWindow terminal_scroll = new Gtk.ScrolledWindow(null, null);
				Gtk.TextView terminal_view = new Gtk.TextView ();
				terminal_view.editable = false;
				terminal_scroll.add(terminal_view);
				terminal.add(terminal_scroll);
				// Packing stuff
				makefile_preview.pack_start(makefile,true,true,0);
				makefile_preview.pack_start(terminal,true,true,8);
				makefile_master.pack_start(makefile_preview,true,true,0);
				box.pack_start(makefile_master, true, true, 0);
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

		public class ScriptingTab { /* Base to scripting tabs */ }

	} // Scripting
} // Plugins

} // Avalanche
