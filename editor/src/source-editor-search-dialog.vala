/*
 *  This Source Code Form is subject to the terms of the Mozilla Public
 *  License, v. 2.0. If a copy of the MPL was not distributed with this
 *  file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 *                          Copyright(C) 2013
 *                   Christian Ferraz Lemos de Sousa
 *                      Pedro Henrique Lara Campos
 *
 * Note: This source still needs a partial rewrite.
 */
/*
namespace Avalanche {

namespace Tabs {
	public class SourceEditorSearchDialog : Gtk.Dialog {
		private Gtk.Entry search_entry;
		private Gtk.CheckButton match_case;
		private Gtk.CheckButton find_backwards;
		private Gtk.Widget find_button;
		public signal void find_next(string text, bool case_sensitivity);
		public signal void find_previous(string text, bool case_sensitivity);

		public SourceEditorSearchDialog() {
			this.title = "Find";
			this.border_width = 5;
			set_modal(true);
			set_default_size(350, 100);
			create_widgets();
			connect_signals();
		}

		private void toggled(Gtk.ToggleButton button) {
			stdout.printf("%s\n", button.label);
		}

		private void create_widgets() {
			Gtk.Box content = get_content_area();
			//
			this.search_entry = new Gtk.Entry();
			Gtk.Label search_label = new Gtk.Label.with_mnemonic("_Search for:");
			search_label.mnemonic_widget = this.search_entry;
			//
			this.match_case = new Gtk.CheckButton.with_mnemonic("_Match case");
			this.find_backwards = new Gtk.CheckButton.with_mnemonic("Find _backwards");
			// Layout widgets
			var hbox = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 20);
			hbox.pack_start(search_label, false, true, 0);
			hbox.pack_start(this.search_entry, true, true, 0);
			//
			content.pack_start(hbox, false, true, 0);
			content.pack_start(this.match_case, false, true, 0);
			content.pack_start(this.find_backwards, false, true, 0);
			content.spacing = 10;
			//
			Gtk.Label source_label = new Gtk.Label("Search source:");
			content.pack_start(source_label, false, true, 0);
			// search source control
			Gtk.Box sourcebox = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 0);
			Gtk.Box source_col1 = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
			Gtk.Box source_col2 = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
			content.add(sourcebox);
			// search on the current script
			Gtk.RadioButton button1 = new Gtk.RadioButton.with_label_from_widget(null, "Current Script ");
			source_col1.pack_start(button1, true, true, 0);
			button1.toggled.connect(toggled);
			button1.set_active(true);
			// search on the default scripts
			Gtk.RadioButton button = new Gtk.RadioButton.with_label_from_widget(button1, "Default Scripts");
			source_col2.pack_start(button, true, true, 0);
			button.toggled.connect(toggled);
			// search on the custom scripts
			button = new Gtk.RadioButton.with_label_from_widget(button1, "Custom Scripts");
			source_col1.pack_start(button, true, true, 0);
			button.toggled.connect(toggled);
			// search on every script
			button = new Gtk.RadioButton.with_label_from_widget(button1, "Every Script");
			source_col2.pack_start(button, true, true, 0);
			button.toggled.connect(toggled);
			// packing radios
			sourcebox.pack_start(source_col1, true, true);
			sourcebox.pack_start(source_col2, true, true);
			// search results
			add_button(Gtk.Stock.CLOSE, Gtk.ResponseType.CLOSE);
			this.find_button = add_button(Gtk.Stock.FIND, Gtk.ResponseType.APPLY);
			this.find_button.sensitive = false;
		}

		private void connect_signals() {
			this.search_entry.changed.connect(() => {
				this.find_button.sensitive =(this.search_entry.text != "");
			});
			this.response.connect(on_response);
		}

		private void on_response(Gtk.Dialog source, int response_id) {
			switch(response_id) {
			case Gtk.ResponseType.HELP:
				// show_help(); // DISABLED FOR NOW
				break;
			case Gtk.ResponseType.APPLY:
				on_find_clicked();
				break;
			case Gtk.ResponseType.CLOSE:
				destroy();
				break;
			}
		}

		private void on_find_clicked() {
			// search through scripts
			string text = this.search_entry.text;
			bool cs = this.match_case.active;
			if(this.find_backwards.active) {
				find_previous(text, cs);
			} else {
				find_next(text, cs);
			}
		}
	}
} // Tabs

} // Avalanche
*/
