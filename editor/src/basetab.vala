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

namespace Plugins {

	// A very dynamic base for tabs
	public interface Tab : Object {
		public abstract void show(Gtk.Notebook notebook);
		public abstract void hide();
		public abstract void create_menu();
		public abstract void session_save();
		public abstract void session_load();
	}

} // Plugins

} // Avalanche
