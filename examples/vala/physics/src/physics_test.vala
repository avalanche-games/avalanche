// From: http://code.google.com/p/chipmunk-physics/source/browse/trunk/example/hello_chipmunk.c
// Ported to Avalanche-VALA by PedroHLC

namespace AvalanchePhysicsExample {

public class PhysicsTestState : Aval.ScreenState,  GLib.Object {
	private cp.Vect gravity;
	private cp.Space space;
	private cp.SegmentShape ground;
	private Ball ball;
	private SDL.Texture ground_texture;
	private static const double TIME_STEP = 1.0/60.0; //should be 1/FPS
	
	public void on_enter () {
		// cp.Vect is a 2D vector
		gravity = {0, 1};
			
		// Create an empty space.
		space = new cp.Space();
		space.gravity = gravity;
			
		// Add a static LINE SEGMENT shape for the ground.
		// We'll make it slightly tilted so the ball will roll off.
		// We attach it to space.static_body to tell Chipmunk it shouldn't be movable.
		ground = new cp.SegmentShape (space.static_body, {0, 580}, {800, 581}, 0);
		ground.u = 1; //u = friction
		space.add_shape (ground);
		
		// Now let's make a ball that falls onto the line and rolls off.
		// First we need to make a cpBody to hold the physical properties of the object.
		// These include the mass, position, velocity, angle, etc. of the object.
		// Then we attach collision shapes to the cpBody to give it a size and shape.
		ball = new Ball (space);
		
		// Load ground texture
		ground_texture = SDLImage.load_texture (Aval.Game.WIN_RENDERER, "../res/wall.png");
	}
	
	public void on_update (SDL.Event e) {
		// Ball can't get out of screen
		ball.update ();
		
		// Now that it's all set up, we simulate all the objects in the space by
		// stepping forward through time in small increments called steps.
		// It is *highly* recommended to use a fixed size time step.
		space.step (TIME_STEP);
	}
	
	public void draw () {
		ball.draw ();
		
		Aval.Game.WIN_RENDERER.copy (ground_texture,
			{0, 0, 414, 20}, // Image input pos and size
			{0, 580, 800, 20}); //Output pos and size
	}
	
	public void on_leave () {}
}// PhysicsTestState

public class Ball {
	private static const double RADIUS = 32;
	private static const double MASS = 5;
	private cp.Body body;
	private cp.CircleShape shape;
	private SDL.Texture texture;
	
	public Ball (cp.Space space) {
		// The moment of inertia is like mass for rotation
		// Use the 'cp.moment_for_*' functions to help you approximate it.
		double moment = cp.moment_for_circle(MASS, 0, RADIUS, {0, 0});
			
		// The cpSpaceAdd*() functions return the thing that you are adding.
		// It's convenient to create and add an object in one line.
		body = new cp.Body(MASS, moment);
		space.add_body (body);
		body.set_pos({64-RADIUS, 0-RADIUS});
		
		// Now we create the collision shape for the ball.
		// You can create multiple collision shapes that point to the same body.
		// They will all be attached to the body and move around to follow it.
		shape = new cp.CircleShape (body, RADIUS, {0, 0});
		space.add_shape (shape);
		shape.u = 0.7; //u = friction
		
		// Load ball texture
		texture = SDLImage.load_texture (Aval.Game.WIN_RENDERER, "../res/ball.png");
	}
	
	public void update () {
		if (body.p.x-64 > 800 || body.p.y-64 > 600)
			body.set_pos({64-RADIUS, 0-RADIUS});
	}
	
	public void draw () {
		Aval.Game.WIN_RENDERER.copyex (texture, //Texture
			{0, 0, 256, 256}, // Image input pos and size
			{(int)(body.p.x-RADIUS), (int)(body.p.y-RADIUS), 64, 64}, //Output pos and size
			body.a*57.29578, // Angle (converted from radians to degrees)
			null, // enter point for rotation (NULL uses half width and half height)
			SDL.RendererFlip.NONE ); //Flip
	}
} // Ball


}// AvalanchePhysicsExample