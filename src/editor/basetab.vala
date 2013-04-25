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

namespace Tabs {
	public interface Base : Object {
		// A very dynamic base for tabs
		public abstract void setup(Gtk.Notebook notebook);
	}
}

} // Avalanche
