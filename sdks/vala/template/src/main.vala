namespace MyGame {

public class Main : Avalanche.Game {
        public static void main () {
		// Intialize SDL, SDLImage and Avalanche.
		init(SDL.InitFlag.EVERYTHING, SDLImage.InitFlags.PNG);
		
		// Create window and render separately.
		WINDOW = new SDL.Window ("VALA-Avalanche Example", SDL.Window.POS_CENTERED,
			SDL.Window.POS_CENTERED, 640, 480, SDL.WindowFlags.SHOWN);
		WIN_RENDERER = new SDL.Renderer (WINDOW, -1, SDL.RendererFlags.ACCELERATED | SDL.RendererFlags.PRESENTVSYNC);
		
		// Loads sample image and put on a texture.
		SDL.Texture sample_tex = SDLImage.load_texture (WIN_RENDERER, "./sample.png");
		
		// clear renderer, copy texture, present renderer.
		WIN_RENDERER.clear();
		WIN_RENDERER.copy(sample_tex, null, null);
		WIN_RENDERER.present ();
		
		// Enter in main loop.
		main_loop ();
		
		// Quit SDL and valanche module.
		quit();
	}
}// Main


}// MyGame