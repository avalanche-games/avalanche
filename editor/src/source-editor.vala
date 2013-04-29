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
		private Gtk.SourceView editor = new Gtk.SourceView();
		private Gtk.TreeView cstm_view;
		private Gtk.TreeView dflt_view;
		private Gtk.TreeStore cstm_model;
		private Gtk.TreeStore dflt_model;
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

		private Gtk.TreeView setup_script_list(Gtk.TreeStore store) { 
			Gtk.TreeIter root;
			Gtk.TreeIter category_iter;
			Gtk.TreeIter product_iter;
			Gtk.TreeView view = new Gtk.TreeView.with_model(store);
			view.set_headers_visible(false);
			view.insert_column_with_attributes (-1, "Icon", new Gtk.CellRendererPixbuf (), "pixbuf", 1, null);
			view.insert_column_with_attributes (-1, "Name", new Gtk.CellRendererText (), "text", 0, null);
			store.append (out root, null);
			store.set (root, 1, new Gdk.Pixbuf.from_file("/usr/lib/avalanche/icons/vala.png"), 0, "afafaf", -1);
			return(view);
		}

		private void setup_sidebar(Gtk.Box sidebar_container) {
			// Creates a organized script sidebar
			Gtk.Notebook sidebar_tabs = new Gtk.Notebook();
			// Setup scrollbar
			Gtk.ScrolledWindow cstm_scripts  = new Gtk.ScrolledWindow(null, null);
			Gtk.ScrolledWindow dflt_scripts  = new Gtk.ScrolledWindow(null, null);
			// Adding scripts
			this.cstm_model = new Gtk.TreeStore(2, typeof (string), typeof (Gdk.Pixbuf));
			this.dflt_model = new Gtk.TreeStore(2, typeof (string), typeof (Gdk.Pixbuf));
			this.cstm_view = setup_script_list(this.cstm_model);
			this.dflt_view = setup_script_list(this.dflt_model);
			// Making the view visible
			cstm_scripts.add(this.cstm_view);
			dflt_scripts.add(this.dflt_view);
			// Appending every page in the script sidebar
			sidebar_tabs.append_page(cstm_scripts,  new Gtk.Label("Custom"));
			sidebar_tabs.append_page(dflt_scripts,  new Gtk.Label("Standard"));
			sidebar_tabs.tab_pos = Gtk.PositionType.BOTTOM;
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
	}
} // Tabs

} // Avalanche
