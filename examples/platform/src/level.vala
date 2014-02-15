namespace Platform {

public class Level {
	private cp.SegmentShape ground;
	
	public Level (cp.Space space) {
		// Add a static LINE SEGMENT shape for the ground.
		// We attach it to space.static_body to tell Chipmunk it shouldn't be movable.
		// * ground.u = ground friction
		ground = new cp.SegmentShape (space.static_body, {0, 400}, {Aval.Game.WW, 401}, 0);
		ground.u = 1;
		space.add_shape (ground);
	}
	
	public void on_event (SDL.Event e) {	

	}
	
	public void update () {
	}
	
	public void draw () {
	}
	
	public void dispose () {
	}
	
	public void physics_dispose (cp.Space space) {
		space.remove_shape (this.ground);
	}
} // Ground


}// Level