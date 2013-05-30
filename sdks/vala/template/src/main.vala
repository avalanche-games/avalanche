namespace AvalancheTemplate {

public class Main : Avalanche.Game {
	public static void main () {
		// Intialize SDL, SDLImage and Avalanche.
		init(SDL.InitFlag.EVERYTHING, SDLImage.InitFlags.PNG);
		
		// Create window and render separately.
		WINDOW = new SDL.Window ("VALA-Avalanche Example", SDL.Window.POS_CENTERED,
			SDL.Window.POS_CENTERED, 640, 480, SDL.WindowFlags.SHOWN);
		WIN_RENDERER = new SDL.Renderer (WINDOW, -1, SDL.RendererFlags.ACCELERATED | SDL.RendererFlags.PRESENTVSYNC);
		
		// Select the first screenstate
		change_state (new SampleIMGState ());
		
		// Core
		while (STATE != null) {
			STATE.on_enter (); // Welcome...
			main_loop (STATE); // ...to the work
		}
		
		// Quit SDL and valanche module.
		quit ();
	}
}// Main


}// AvalancheTemplate