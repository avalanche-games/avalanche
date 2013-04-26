namespace MyGame {

public class Main {
	protected static SDL.Window window;
	
        public static void main () {
		SDL.init ();
		
		window = new SDL.Window ("Testing SDL 2.0 in Vala", SDL.Window.POS_CENTERED, SDL.Window.POS_CENTERED, 640, 480, SDL.WindowFlags.RESIZABLE);
		window.show ();
		
		Avalanche.Game.use_window(window);
		
		SDL.Event e;
		for (e = {0}; e.type != SDL.EventType.QUIT; SDL.Event.poll (out e)){ 
			window.update_surface ();
			SDL.Timer.delay(10);
		}
		
		window.destroy (); //Actually useless since it is called when window is disposed
		
		SDL.quit ();
	}
}// Main


}// MyGame