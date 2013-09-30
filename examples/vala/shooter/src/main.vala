namespace Shooter {

public class Main : Aval.Game {
	// Window static width
	public static const int WW = 800;
	// Window static height
	public static const int WH = 480;
	
	public static Rand RANDOM;
	
	#if AVALANCE_WIN
		[CCode (cname="WinMain")]
	#endif
	public static int main () {
		// Intialize SDL, SDLImage and Avalanche.
		init(SDL.InitFlag.EVERYTHING, SDLImage.InitFlags.PNG);
		
		// Initialize our random number generator
		RANDOM = new Rand();
		
		// Setup Avalanche
		set_fps (60);
		
		// Create window and render separately.
		WINDOW = new SDL.Window ("Shooter", SDL.Window.POS_CENTERED,
			SDL.Window.POS_CENTERED, WW, WH, SDL.WindowFlags.SHOWN);
		WIN_RENDERER = new SDL.Renderer (WINDOW, -1, SDL.RendererFlags.ACCELERATED | SDL.RendererFlags.PRESENTVSYNC);
		
		// Select the first screenstate
		change_state (new Game1 ());
		
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


}// Shooter