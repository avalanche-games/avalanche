namespace AvalanchePhysicsExample {

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
		WINDOW = new SDL.Window ("VALA-Avalanche Physics Example", SDL.Window.POS_CENTERED,
			SDL.Window.POS_CENTERED, 800, 600, SDL.WindowFlags.SHOWN);
		WIN_RENDERER = new SDL.Renderer (WINDOW, -1, SDL.RendererFlags.ACCELERATED | SDL.RendererFlags.PRESENTVSYNC);
		
		// Select the first screenstate
		change_state (new PhysicsTestState ());
		
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


}// AvalanchePhysicsExample