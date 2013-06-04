 /*
 *	This Source Code Form is subject to the terms of the Mozilla Public
 *	License, v. 2.0. If a copy of the MPL was not distributed with this
 *	file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 *													Copyright(C) 2013
 *									 Christian Ferraz Lemos de Sousa
 *											Pedro Henrique Lara Campos
 */
namespace Avalanche {

namespace Application {

	public class OpenDialog : Gtk.FileChooserDialog {

		private string last_folder;
		private Gtk.FileFilter filter = new Gtk.FileFilter();

		public OpenDialog (string pattern, bool multiple = false, string title = "Open File") {
			// Dialog settings
			this.title = title;
			this.action = Gtk.FileChooserAction.OPEN;
			this.select_multiple = multiple;

			// Filter to .apl files
			filter.add_pattern(pattern);
			set_filter(filter);

			// Action buttons
			add_button (Gtk.Stock.CANCEL, Gtk.ResponseType.CANCEL);
			add_button (Gtk.Stock.OPEN, Gtk.ResponseType.ACCEPT);
			set_default_response (Gtk.ResponseType.ACCEPT);

			// Current folder
			if (this.last_folder != null) {
				set_current_folder (this.last_folder);
			}
		}

		public string get_last_folder() {
			// Return the last folder
			return this.last_folder;
		}

		public override void response (int type) {
			// Set current folder
			if (type == Gtk.ResponseType.ACCEPT)
				this.last_folder = get_current_folder ();
		}
	}


} // Application

}