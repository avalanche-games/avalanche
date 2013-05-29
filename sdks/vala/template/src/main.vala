namespace MyGame {

public class Main : Avalanche.Game {
        public static void main () {
		init(SDL.InitFlag.EVERYTHING, SDLImage.InitFlags.ALL);
		
		WINDOW = new SDL.Window ("Avalanche Vala SDK Example", SDL.Window.POS_CENTERED,
			SDL.Window.POS_CENTERED, 640, 480, SDL.WindowFlags.SHOWN);
		
		main_loop ();
		
		quit();
	}
}// Main


}// MyGame