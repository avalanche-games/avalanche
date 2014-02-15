namespace Platform {

public class Main : Aval.Game {
	public static Rand RANDOM;
	
	#if AVALANCHE_JNI
		[CCode (cname="Java_avalanche_Game_launch")]
	#elif AVALANCHE_WIN
		[CCode (cname="WinMain")]
	#endif
	public static void main () {
		// Intialize SDL, SDLImage and Avalanche.
		init(SDL.InitFlag.EVERYTHING, SDLImage.InitFlags.PNG);
		
		// Initialize SDLMixer
		SDLMixer.open (48000, SDL.AudioFormat.S16SYS, 2, 4096);
		
		// Initialize our random number generator
		RANDOM = new Rand();
		
		// Setup Avalanche
		// If you're using SDL.RendererFlags.PRESENTVSYNC you must set this to 0
		set_fps (60);
		
		// Create window and render separately.
		WINDOW = new SDL.Window ("Platformer", SDL.Window.POS_CENTERED,
			SDL.Window.POS_CENTERED, 960, 544, SDL.WindowFlags.SHOWN | SDL.WindowFlags.RESIZABLE);
		Aval.Game.WINDOW.get_size(out WW, out WH);
		WIN_RENDERER = new SDL.Renderer (WINDOW, -1, SDL.RendererFlags.ACCELERATED);
		
		// Select the first screenstate
		change_state (new Game1 ());
		
		// Core
		while (STATE != null) {
			STATE.on_enter (); // Welcome...
			main_loop (); // ...to the work
		}
		
		// Quit SDL and valanche module.
		quit ();
	}
}// Main


}// Platform