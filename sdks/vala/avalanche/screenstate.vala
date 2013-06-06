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

namespace Aval {

public interface ScreenState : GLib.Object {
	public abstract void on_enter ();
	public abstract void on_update (SDL.Event e);
	public abstract void draw ();
	public abstract void on_leave ();
}

}// Aval