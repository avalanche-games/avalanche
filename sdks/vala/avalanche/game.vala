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
	internal static uint32 FRAME_EACHONE_TIME;
	internal static uint32 FRAME_LAST_SEC;
	internal static uint32 FRAME_NEXT_SEC;
	internal static uint8 FRAME_CURR;
	
	public static void init (SDL.InitFlag sdl_flags, SDLImage.InitFlags img_flags) {
		SDL.init (sdl_flags);
		SDLImage.init (img_flags);
		fps_endsec (SDL.Timer.get_ticks ());
		
		// CHDIR on executable path
		string path=".";
		#if AVALANCE_WIN
			path = GLib.Win32.get_package_installation_directory_of_module (null);
			path += "\\bin";
		#elif AVALANCE_UNIX
			char path_buf[1024];
			char *dirend;
			Posix.readlink ("/proc/self/exe", path_buf);
			dirend = (char*)Posix.strrchr ((string)path_buf, '/');
			dirend[0] = '\0';
			path = (string)path_buf;
		#endif
		Posix.chdir (path);
	}
	
	public static void main_loop () {
		Aval.ScreenState enginer = STATE;
		
		SDL.Event e;
		for (e = {0} ;; SDL.Event.poll (out e)) {
			// Update state
			STATE.on_update (e);
			
			// Quit the loop if this is no longer the actual STATE
			if (STATE != enginer)
				break;
			
			// Draw screen
			loop_frame ();
			
			// Quit the game correctly
			// -To jump this, threat the event and set it type to 0
			if (e.type == SDL.EventType.QUIT){
				Aval.Game.change_state (null);
				break;
			}
		}
	}
	
	internal static void fps_endsec (uint32 start_ticks) {
		FRAME_LAST_SEC = start_ticks;
		FRAME_NEXT_SEC = start_ticks +1000;
		FRAME_CURR = 0;
	}
	
	public static void loop_frame () {	
		// FPS controlling - Temporary version
		uint32 current_ticks = SDL.Timer.get_ticks ();
		SDL.Timer.delay (FRAME_EACHONE_TIME);
		if (current_ticks >= FRAME_NEXT_SEC)
			fps_endsec (current_ticks);
		FRAME_CURR++;
		
		// Render
		WIN_RENDERER.clear();
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
	
	public static void set_fps (uint8 nframe_rate) {
		FRAME_EACHONE_TIME = (1000 / nframe_rate);
	}
}// Game


}// Aval