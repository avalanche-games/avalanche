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

	// Scripting Plugin
	namespace Scripting {

		// Avalanche's SourceView script editor
		public class Editor : Object {

			// Constructs a editor bound to the filename
			public Editor(string filename) {
				// TODO: Figure out the language by ourselves
				File file = File.new_for_path(Environment.get_home_dir() + "/.local/share/Avalanche/DebugProject/src/" +
				                              "sample-script.vala");
				/*setup_new_editor(file);
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
				content.pack_start(division, true, true);*/
			}

			// Destroys the childs
			~Editor() {
				//this.content.destroy();
			}
		}

	} // Scripting

} // Plugins

}