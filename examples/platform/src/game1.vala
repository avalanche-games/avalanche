namespace Platform {

public class Game1 : Aval.ScreenState,  GLib.Object {
	private static const cp.Vect GRAVITY = {0, 0.2f};
	private cp.Space space;
	private static const double TIME_STEP = 1.0/60.0; //should be 1/FPS
	
	Player player;
	Level level;
	
	public void on_enter () {
		// Create an empty space.
		space = new cp.Space();
		space.gravity = GRAVITY;
		
		// Initialize level (background and ground)
		level = new Level (space);
		
		// Initialize the player class
		player = new Player ({120, 0}, space);
	}
	
	public void on_event (SDL.Event e) {
		// Let player & level classes also know about the event
		level.on_event (e);
		player.on_event (e);
	}
	
	public void on_update () {
		// Update level
		level.update ();
		
		// Update player
		player.update ();
		
		// Physics step forward
		for(double time = 0; time < 2; time += TIME_STEP){
			space.step (TIME_STEP);
		}
	}
	
	public void draw () {
		// Draw the Level
		level.draw ();
		
		// Draw the Player
		player.draw ();
	}
	
	public void on_leave () {
		// - Vala is smart and do A LOT of those automatically, but nothing better than be precautious
		player.physics_dispose (space);
		player.dispose ();
		player = null;
		
		level.physics_dispose (space);
		level.dispose ();
		level = null;
	}
}// SampleIMGState


}// Platform