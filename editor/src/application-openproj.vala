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

	public class OpenProjectDialog : Gtk.FileChooserDialog {

		private string last_folder;
		private Gtk.FileFilter filter = new Gtk.FileFilter();

		public OpenProjectDialog () {
			// Dialog settings
			this.title = "Open File";
			this.action = Gtk.FileChooserAction.OPEN;
			this.select_multiple = false;
			// Filter to .apl files
			filter.add_pattern("*.apj");
			set_filter(filter);
			// Action buttons
			add_button (Gtk.Stock.CANCEL, Gtk.ResponseType.CANCEL);
			add_button (Gtk.Stock.OPEN, Gtk.ResponseType.ACCEPT);
			set_default_response (Gtk.ResponseType.ACCEPT);
			// current folder
			if (this.last_folder != null) {
				set_current_folder (this.last_folder);
			}
		}

		public override void response (int type) {
			if (type == Gtk.ResponseType.ACCEPT)
				this.last_folder = get_current_folder ();
		}
	}


} // Application

}