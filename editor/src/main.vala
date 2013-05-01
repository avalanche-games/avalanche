/*
 *  This Source Code Form is subject to the terms of the Mozilla Public
 *  License, v. 2.0. If a copy of the MPL was not distributed with this
 *  file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 *                          Copyright(C) 2013
 *                   Christian Ferraz Lemos de Sousa
 *                      Pedro Henrique Lara Campos
 */

namespace Avalanche {

// Main is not going to be instantiated/inherited
public class Main {

	public static int main(string[] args) {
		// Gtk setup
		Gtk.init(ref args);
		// TODO: dark theme as runtime setting
		#if (DARK_THEME)
		Gtk.Settings.get_default().gtk_application_prefer_dark_theme = true;
		#endif
		// Launch Avalanche
		Application avalanche = new Application();
		avalanche.show_all();
		Gtk.main();
		// No errors
		return 0;
	}

} // class:Main

} // Avalanche
