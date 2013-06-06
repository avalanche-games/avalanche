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

namespace AvalancheTemplate {

public class Main : Aval.Game {
	#if AVALANCE_WIN
		[CCode (cname="WinMain")]
	#endif
	public static int main () {
		// Intialize SDL, SDLImage and Avalanche.
		init(SDL.InitFlag.EVERYTHING, SDLImage.InitFlags.PNG);
		
		// Setup Avalanche
		set_fps (60);
		
		// Create window and render separately.
		WINDOW = new SDL.Window ("VALA-Avalanche Example", SDL.Window.POS_CENTERED,
			SDL.Window.POS_CENTERED, 640, 480, SDL.WindowFlags.SHOWN);
		WIN_RENDERER = new SDL.Renderer (WINDOW, -1, SDL.RendererFlags.ACCELERATED | SDL.RendererFlags.PRESENTVSYNC);
		
		// Select the first screenstate
		change_state (new SampleIMGState ());
		
		// Core
		while (STATE != null) {
			STATE.on_enter (); // Welcome...
			main_loop (); // ...to the work
		}
		
		// Quit SDL and valanche module.
		quit ();
		
		return 0;
	}
}// Main


}// AvalancheTemplate