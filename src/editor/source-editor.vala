/*
 *  This Source Code Form is subject to the terms of the Mozilla Public
 *  License, v. 2.0. If a copy of the MPL was not distributed with this
 *  file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 *                          Copyright(C) 2013
 *                   Christian Ferraz Lemos de Sousa
 *                      Pedro Henrique Lara Campos
 *
 * TODO: Create a default file format
 *       Finish the search dialog
 *       Setup a Script Name Hash(how I'd forgot that)
 *
 * Note: This source still needs a partial rewrite to act more efficiently
 */

namespace Avalanche {

namespace Tabs {
	public class SourceEditor : Object, Base {
		private Gee.ArrayList<string> cstm_data = new Gee.ArrayList<string>();
		private Gee.ArrayList<string> dflt_data = new Gee.ArrayList<string>();
		private Gtk.SourceView editor = new Gtk.SourceView();
		private Gtk.TreeView cstm_view;
		private Gtk.TreeView dflt_view;
		private Gtk.ListStore cstm_model;
		private Gtk.ListStore dflt_model;
		private int cstm_index = 0;
		private int dflt_index = 0;
		private uint cstm_size = 0;
		private uint dflt_size = 0;
		private uint current_page = 0;
		private Gtk.Box title   = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 0);
		private Gtk.Box content = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);


		public SourceEditor() {
		}

		~SourceEditor() {
			// Destructor
			this.content.destroy ();
			this.title.destroy ();
		}


		public void setup(Gtk.Notebook notebook) {
			Gtk.Box sidebar           = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
			Gtk.ScrolledWindow editor = new Gtk.ScrolledWindow(null, null);
			setup_sidebar(sidebar);
			setup_editor (editor);
			setup_content(sidebar, editor);
			notebook.append_page (this.content, this.title);
			notebook.set_tab_reorderable (this.content, true);
		}

		private Gtk.TreeView setup_script_list(Gee.ArrayList<string> data, Gtk.ListStore list_store) {
			// Creates a script list
			Gtk.TreeIter iter;
			for(int i = 0; i < 10; i++){
				// TODO: replace it by a data loading function :D
				list_store.append(out iter);
				list_store.set(iter, 0, "%d".printf(i));
				data.insert(i, "%d".printf(i));
			}
			// Cell and view creation
			Gtk.CellRendererText cell = new Gtk.CellRendererText();
			Gtk.TreeView view = new Gtk.TreeView.with_model(list_store);
			// View settings
			view.insert_column_with_attributes(-1, "", cell, "text", 0);
			view.reorderable = true;
			view.enable_search = true;
			view.headers_visible = false;
			view.get_selection().set_mode(Gtk.SelectionMode.SINGLE);
			view.cursor_changed.connect(on_cursor_changed);
			// Enable cell editing
			cell.editable = true;
			cell.edited.connect(on_edited);
			return(view);
		}

		private void setup_sidebar(Gtk.Box sidebar_container) {
			// Creates a organized script sidebar
			Gtk.Notebook sidebar_tabs = new Gtk.Notebook();
			// Setup scrollbar
			Gtk.ScrolledWindow cstm_scripts  = new Gtk.ScrolledWindow(null, null);
			Gtk.ScrolledWindow dflt_scripts  = new Gtk.ScrolledWindow(null, null);
			// Adding scripts
			this.cstm_model = new Gtk.ListStore(1, typeof(string));
			this.dflt_model = new Gtk.ListStore(1, typeof(string));
			this.cstm_view = setup_script_list(this.cstm_data, this.cstm_model);
			this.dflt_view = setup_script_list(this.dflt_data, this.dflt_model);
			this.cstm_size = 9;
			this.dflt_size = 9;
			// Making the view visible
			cstm_scripts.add(this.cstm_view);
			dflt_scripts.add(this.dflt_view);
			// Appending every page in the script sidebar
			sidebar_tabs.append_page(cstm_scripts,  new Gtk.Label("Custom"));
			sidebar_tabs.append_page(dflt_scripts,  new Gtk.Label("Standard"));
			sidebar_tabs.tab_pos = Gtk.PositionType.BOTTOM;
			sidebar_tabs.switch_page.connect(on_switch_page);
			// Connect the signal
			this.cstm_model.row_changed.connect(on_row_changed);
			this.dflt_model.row_changed.connect(on_row_changed);
			// Down content
			Gtk.Box footer     = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 1);
			Gtk.Box add_remove = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 1);
			// New script btn
			Gtk.Image  new_img = new Gtk.Image.from_stock(Gtk.Stock.NEW, Gtk.IconSize.MENU);
			Gtk.Button new_btn = new Gtk.Button();
			new_btn.set_tooltip_text("New Script");
			new_btn.always_show_image = true;
			new_btn.image = new_img;
			new_btn.label = "New";
			// Delete script
			Gtk.Image  delete_img = new Gtk.Image.from_stock(Gtk.Stock.DELETE, Gtk.IconSize.MENU);
			Gtk.Button delete_btn = new Gtk.Button();
			delete_btn.set_tooltip_text("Delete Script");
			delete_btn.always_show_image = true;
			delete_btn.image = delete_img;
			// Search dialog btn
			Gtk.Image  search_img = new Gtk.Image.from_stock(Gtk.Stock.FIND, Gtk.IconSize.MENU);
			Gtk.Button search_btn = new Gtk.Button();
			search_btn.set_tooltip_text("Search Dialog");
			search_btn.always_show_image = true;
			search_btn.image = search_img;
			// Adding buttons
			add_remove.pack_start( new_btn, false, false);
			add_remove.pack_start(delete_btn, false, false);
			// Packing the footer
			footer.pack_start(add_remove, true, true);
			footer.pack_end  (search_btn,false, false);
			// Signal connection
			new_btn.clicked.connect(on_clicked_new);
			delete_btn.clicked.connect(on_clicked_delete);
			search_btn.clicked.connect(on_clicked_search);
			// Adding sidebar
			sidebar_container.pack_start(sidebar_tabs, true, true, 0);
			sidebar_container.pack_end(footer, false, false, 0);
		}

		private void setup_editor(Gtk.ScrolledWindow editor_container) {
			// Creates a source editor
			Gtk.SourceBuffer buffer = new Gtk.SourceBuffer.with_language
				                         (Gtk.SourceLanguageManager.get_default().get_language("vala"));
			buffer.style_scheme = Miscellaneuous.get_syntax_style();
			// Editor settings
			this.editor.buffer = buffer;
			this.editor.right_margin_position = 120;       this.editor.set_show_right_margin(true);
			this.editor.set_show_line_numbers(true);      this.editor.set_show_line_marks(true);
			this.editor.set_highlight_current_line(true); this.editor.set_indent_width(4);
			this.editor.set_tab_width(4);                 this.editor.set_indent_on_tab(true);
			this.editor.set_auto_indent(true);            this.editor.set_insert_spaces_instead_of_tabs(false);
			this.editor.override_font(Pango.FontDescription.from_string("Liberation Mono 11"));
			this.editor.draw_spaces = (Gtk.SourceDrawSpacesFlags.SPACE    + Gtk.SourceDrawSpacesFlags.TAB +
				                       Gtk.SourceDrawSpacesFlags.TRAILING + Gtk.SourceDrawSpacesFlags.NEWLINE);
			this.editor.buffer.set_text(this.cstm_data.get(0));
			// Adding the editor
			editor_container.set_policy(Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.AUTOMATIC);
			editor_container.add(this.editor);
		}

		private void setup_content( Gtk.Widget sidebar, Gtk.Widget editor) {
			// Adds the sidebar and editor to the tab content
			this.title.pack_start(new Gtk.Label("Programming"), false, false, 0);
			this.title.pack_start(new Gtk.Button(), false, false, 0);
			this.title.show_all  ();
			Gtk.Paned division = new Gtk.Paned(Gtk.Orientation.HORIZONTAL);
			division.pack1(sidebar, false, false);
			division.pack2(editor, true, false);
			this.content.pack_start(division);
		}


		private void on_clicked_new() {
			// Creates a new script in the cursor position
			string script = "/*\n * Hack with Vala here\n *\n */";
			if(this.current_page == 0) {
				Gtk.TreePath path = new Gtk.TreePath.from_string("%d".printf(this.cstm_index));
				Gtk.TreeIter iter;
				this.cstm_model.get_iter(out iter, path);
				this.cstm_data.insert(this.cstm_index+1, script);
				this.cstm_model.insert(out iter, this.cstm_index + 1);
				this.cstm_model.set(iter, 0, "New Script");
				this.cstm_size += 1;
			}else {
				Gtk.TreePath path = new Gtk.TreePath.from_string("%d".printf(this.dflt_index));
				Gtk.TreeIter iter;
				this.dflt_model.get_iter(out iter, path);
				this.dflt_data.insert(this.dflt_index+1, script);
				this.dflt_model.insert(out iter, this.dflt_index + 1);
				this.dflt_model.set(iter, 0, "New Script");
				this.dflt_size += 1;
			}
		}

		private void on_clicked_delete() {
			// Delete the current script.
			if(this.current_page == 0) {
				if(this.cstm_size > 0) {
					Gtk.TreePath path = new Gtk.TreePath.from_string("%d".printf(this.cstm_index));
					Gtk.TreeIter iter;
					this.cstm_data.remove_at(this.cstm_index);
					this.cstm_model.get_iter(out iter, path);
					if(this.cstm_index == this.cstm_size) {
						this.cstm_index -= 1;
					}
					this.editor.buffer.set_text(cstm_data.get(this.cstm_index));
					this.cstm_model.remove(iter);
					this.cstm_size -= 1;
				}
			}else {
				if(this.dflt_size > 0) {
					Gtk.TreePath path = new Gtk.TreePath.from_string("%d".printf(this.dflt_index));
					Gtk.TreeIter iter;
					this.dflt_data.remove_at(this.dflt_index);
					this.dflt_model.get_iter(out iter, path);
					if(this.dflt_index == this.dflt_size) {
						this.dflt_index -= 1;
					}
					this.editor.buffer.set_text(dflt_data.get(this.dflt_index));
					this.dflt_model.remove(iter);
					this.dflt_size -= 1;
				}
			}
		}

		private void on_clicked_search() {
			// Open a seach dialog
			SourceEditorSearchDialog dialog = new SourceEditorSearchDialog();
			dialog.show_all();
		}

		private void on_cursor_changed() {
			// Changes the script on the editor
			Gtk.TreeIter  iter;
			Gtk.TreeModel model;
			Gtk.TextIter  start;
			Gtk.TextIter  end;
			int location;
			if(this.current_page == 0) {
				// Get the index at custom list
				model = this.cstm_view.model;
				this.cstm_view.get_selection().get_selected(out model, out iter);
				location = Miscellaneuous.str_to_int(cstm_model.get_path(iter).to_string());
			}else {
				// Get the index at default list
				model = this.dflt_view.model;
				this.dflt_view.get_selection().get_selected(out model, out iter);
				location = Miscellaneuous.str_to_int(dflt_model.get_path(iter).to_string());
			}
			// Set text iter points
			this.editor.buffer.get_start_iter(out start);
			this.editor.buffer.get_end_iter(out end);
			if(this.current_page == 0) {
				// backup custom script and change editor's text
				cstm_data[this.cstm_index] = this.editor.buffer.get_text(start, end, true);
				this.cstm_index = location;
				this.editor.buffer.set_text(cstm_data.get(this.cstm_index));
			}else {
				// backup default script and change editor's text
				dflt_data[this.dflt_index] = this.editor.buffer.get_text(start, end, true);
				this.dflt_index = location;
				this.editor.buffer.set_text(dflt_data.get(this.dflt_index));
			}
		}

		private void on_row_changed(Gtk.TreePath path, Gtk.TreeIter iter) {
			// Moves a script on the list
			if(this.current_page == 0) {
				// List points
				int remove_from   = this.cstm_index;
				int move_to       = Miscellaneuous.str_to_int(cstm_model.get_path(iter).to_string());
				string tmp_backup = this.cstm_data.get(remove_from);
				string current    = this.cstm_data.get(remove_from);
				// Cursor fastfix
				if(move_to > remove_from) {
					current = this.cstm_data.get(remove_from+1);
					move_to -= 1;
				} else if(move_to < remove_from) {
					current = this.cstm_data.get(remove_from-1);
				}
				// Avoid useless work(and bugs)
				if(move_to != remove_from) {
					this.cstm_data.remove_at(remove_from);
					this.cstm_data.insert(move_to, tmp_backup);
					this.editor.buffer.set_text(current);
				}
				// Back to the old index
				this.cstm_index = remove_from;
			}else {
				// List points
				int remove_from   = this.dflt_index;
				int move_to       = Miscellaneuous.str_to_int(dflt_model.get_path(iter).to_string());
				string tmp_backup = this.dflt_data.get(remove_from);
				string current    = this.dflt_data.get(remove_from);
				// Cursor fastfix
				if(move_to > remove_from) {
					current = this.dflt_data.get(remove_from+1);
					move_to -= 1;
				} else if(move_to < remove_from) {
					current = this.dflt_data.get(remove_from-1);
				}
				// won't do anything if it isn't moved
				if(move_to != remove_from) {
					this.dflt_data.remove_at(remove_from);
					this.dflt_data.insert(move_to, tmp_backup);
					this.editor.buffer.set_text(current);
				}
				// Avoid useless work(and bugs)
				this.dflt_index = remove_from;
			}
		}

		private void on_edited(string path, string new_text) {
			// Renames a script
			Gtk.TreeIter iter;
			if(this.current_page == 0) {
				// Rename a custom script
				this.cstm_model.get_iter_from_string(out iter, path);
				this.cstm_model.set_value(iter, 0,new_text);
			}else {
				// Rename a default script
				this.dflt_model.get_iter_from_string(out iter, path);
				this.dflt_model.set_value(iter, 0,new_text);
			}
		}

		private void on_switch_page(Gtk.Widget page, uint page_num) {
			// Changes the script page
			Gtk.TextIter start;
			Gtk.TextIter end;
			// Setting the start and end iter to it's position
			this.editor.buffer.get_start_iter(out start);
			this.editor.buffer.get_end_iter  (out end);
			// Get the current tab, safely save it and change the text to the another
			if(this.current_page == 0) {
				// Data backup and page change
				cstm_data[this.cstm_index] = this.editor.buffer.get_text(start, end, true);
				this.current_page          = page_num;
				// Changes the script
				this.editor.buffer.set_text(this.dflt_data.get(this.dflt_index));
			}else {
				// Data backup and page change
				dflt_data[this.dflt_index] = this.editor.buffer.get_text(start, end, true);
				this.current_page          = page_num;
				// Changes the script
				this.editor.buffer.set_text(this.cstm_data.get(this.cstm_index));
			}
		}
	}
} // Tabs

} // Avalanche
