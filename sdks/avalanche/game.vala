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

public class Game {
	public static SDL.Window? WINDOW;
	public static SDL.Renderer? WIN_RENDERER;
	public static Aval.ScreenState? STATE;
	private static SDLGraphics.FramerateManager frm;
	public static int WW;
	public static int WH;
	
	public static void init (SDL.InitFlag sdl_flags, SDLImage.InitFlags img_flags) {
		// CHDIR on res path
		#if AVALANCHE_ANDROID
			// TODO OR NOT TODO
		#elif AVALANCHE_JNI
			GLib.Environment.set_current_dir ("../res");
		#elif AVALANCHE_WIN
			string path = GLib.Win32.get_package_installation_directory_of_module (null);
			path += "\\res";
			GLib.Environment.set_current_dir ((string)path);
		#elif AVALANCHE_UNIX
			char path_buf[1024];
			Posix.readlink ("/proc/self/exe", path_buf);
			path_buf[((string)path_buf).last_index_of_char('/')] = '\0';
			Posix.chdir ((string)path_buf + "/../");
			Posix.chdir ("./res/");
		#endif
		
		SDL.init (sdl_flags);
		SDLImage.init (img_flags);
		SDLTTF.init();
		
		frm = {0, 0, 0, 0, 60};
		frm.init ();
	}
	
	public static void main_loop () {
		Aval.ScreenState enginer = STATE;
		
		SDL.Event e;
		while (true) {
			while(true) {
				SDL.Event.poll (out e);
				if (e.type == 0) break;
				
				// When window is resized, store new resolution
				if (e.type == SDL.EventType.WINDOWEVENT) {
					SDL.WindowEvent we = e.window;
					if (we.event == SDL.WindowEventID.SIZE_CHANGED) {
						WW = we.data1;
						WH = we.data2;
					}
				}
				
				// Let STATE also handle it
				STATE.on_event (e);
				
				// Quit the game correctly
				// -To jump this, threat the event and set it type to 0
				if (e.type == SDL.EventType.QUIT) {
					Aval.Game.change_state (null);
					break;
				}
			}
			
			// Quit the loop if this is no longer the actual STATE
			if (STATE != enginer)
				break;
			
			// Update state
			STATE.on_update ();
			
			// Quit the loop if this is no longer the actual STATE (again)
			if (STATE != enginer)
				break;
			
			// Draw screen
			else loop_frame ();
		}
	}
	
	public static void loop_frame () {	
		// Render
		WIN_RENDERER.clear();
		frm.run ();
		STATE.draw ();
		WIN_RENDERER.present ();
	}
	
	public static void quit () {
		if (WINDOW != null)
			WINDOW.destroy (); //Actually useless since it is called when window is disposed
		SDL.quit ();
	}
	
	public static void change_state (Aval.ScreenState? nstate) {
		if (STATE != null) 
			STATE.on_leave ();
		STATE = nstate;
	}
	
	public static void set_fps (int nframe_rate) {
		frm.set_rate (nframe_rate);
	}
}// Game


}// Aval