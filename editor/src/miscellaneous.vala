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

namespace Miscellaneuous {
	public int str_to_int(string convert) {
		// Convert a string to integer
		int output = 0;
		int i = (convert.char_count())-1;
		int v = 0;
		while(i >= 0) {
			var character = convert.get_char(v);
			output += (int)(Math.pow(10, i)*character.digit_value());
			v++;
			i--;
		}
		return output;
	}

	public Gtk.SourceStyleScheme get_syntax_style() {
		// Changes the editor text to match the new page
		string config_path = GLib.Environment.get_user_config_dir();
		#if (Linux)
		Gtk.SourceStyleSchemeManager.get_default().append_search_path(@"$config_path/avalanche-ide");
		Gtk.SourceStyleSchemeManager.get_default().append_search_path("/usr/lib/avalanche/syntax-colors/");
		#elif (Darwin)
		#elif (Windows_NT)
		#endif
		Gtk.SourceStyleSchemeManager.get_default().force_rescan();
		return Gtk.SourceStyleSchemeManager.get_default().get_scheme("tonight");
	}
}

} // Avalanche
