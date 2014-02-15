namespace Platform {

public class Level {
	private cp.SegmentShape ground;
	private SDL.Texture background;
	
	public Level (cp.Space space) {
		background = SDLImage.load_texture (Aval.Game.WIN_RENDERER, "desert.png");
		
		// Add a static LINE SEGMENT shape for the ground.
		// We attach it to space.static_body to tell Chipmunk it shouldn't be movable.
		// * ground.u = ground friction
		ground = new cp.SegmentShape (space.static_body, {-100, Aval.Game.WH * 0.86f - 32}, {Aval.Game.WW+100, Aval.Game.WH * 0.86f - 32}, 1);
		ground.u = 1;
		space.add_shape (ground);
	}
	
	public void on_event (SDL.Event e) {	

	}
	
	public void update () {
	}
	
	public void draw () {
		Aval.Game.WIN_RENDERER.copy (background, null, null);
	}
	
	public void dispose () {
		background = null;
	}
	
	public void physics_dispose (cp.Space space) {
		space.remove_shape (this.ground);
	}
} // Ground


}// Level