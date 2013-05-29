namespace Avalanche {

public class Game {
	public static SDL.Window? WINDOW;
	
	public static void init (SDL.InitFlag sdl_flags, SDLImage.InitFlags img_flags) {
		SDL.init (sdl_flags);
		SDLImage.init (img_flags);
	}
	
	public static void main_loop () {
		SDL.Event e;
		for (e = {0}; e.type != SDL.EventType.QUIT; SDL.Event.poll (out e)) {
			loop_frame ();
		}
	}
	
	public static void loop_frame () {
		WINDOW.update_surface ();
		SDL.Timer.delay (8);
	}
	
	public static void quit () {
		if (WINDOW != null)
			WINDOW.destroy (); //Actually useless since it is called when window is disposed
		SDL.quit ();
	}
}// Game


}// Avalanche