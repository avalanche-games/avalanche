/*
 *  This Source Code Form is subject to the terms of the Mozilla Public
 *  License, v. 2.0. If a copy of the MPL was not distributed with this
 *  file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 *                          Copyright(C) 2013
 *                   Christian Ferraz Lemos de Sousa
 *                      Pedro Henrique Lara Campos
 *
 */

namespace Avalanche {

namespace Plugins {

	// Avalanche's SourceView script editor
	public class Welcome : Object, Tab {

		// Constructs a editor bound to the filename
		public Welcome() {
		}

		// No things to destroy
		~Welcome() { }

		public void show(Gtk.Box container) {
		}

		public void hide() {
		}

		public void create_menu() {
		}

		// Saves the plugin session
		public void session_save() {
		}

		// Loads the plugin session
		public void session_load() {
		}
	}

} // plugins

}