namespace Avalanche {

public class Game {
	public static SDL.Window? WINDOW;
	public static SDL.Renderer? WIN_RENDERER;
	public static Avalanche.ScreenState? STATE;
	
	public static void init (SDL.InitFlag sdl_flags, SDLImage.InitFlags img_flags) {
		SDL.init (sdl_flags);
		SDLImage.init (img_flags);
	}
	
	public static void main_loop (Avalanche.ScreenState enginer) {
		SDL.Event e;
		for (e = {0} ;; SDL.Event.poll (out e)) {
			// Quit the loop if this is no longer the actual STATE
			if (STATE != enginer)
				break;
			
			STATE.on_update ();
			loop_frame ();
			
			// Quit the game correctly
			if (e.type == SDL.EventType.QUIT)
				Avalanche.Game.change_state (null);
		}
	}
	
	public static void loop_frame () {	
		WIN_RENDERER.clear();
		STATE.draw ();
		WIN_RENDERER.present ();
		
		WINDOW.update_surface ();
		SDL.Timer.delay (8); // This will be changed soon....
	}
	
	public static void quit () {
		if (WINDOW != null)
			WINDOW.destroy (); //Actually useless since it is called when window is disposed
		SDL.quit ();
	}
	
	public static void change_state (Avalanche.ScreenState? nstate) {
		if (STATE != null) 
			STATE.on_leave ();
		STATE = nstate;
	}
}// Game


}// Avalanche