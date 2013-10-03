namespace Shooter {

public class Player {
	// Animation representing the player
	SDL.Texture player_texture;
	Aval.Animation player_animation;
	
	// State of the player
	public bool active;
	
	// Amount of hit points that player has
	public uint health;
	
	// A movement speed for the player
	double player_move_speed;
	
	// Movemet holder
	bool moving[4];
	
	// Width and height of the player ship image
	public static const int PLAYER_WIDTH = 115;
	public static const int PLAYER_HEIGHT = 69;
	
	// Physics
	public cp.Body body;
	public cp.SegmentShape shape;
	static const double MASS = 5;
	
	public Player (string texture_path, SDL.Point start_position, cp.Space space) {
		// Load player ship image file directly to texture
		player_texture = SDLImage.load_texture (Aval.Game.WIN_RENDERER, texture_path);
		
		// Create player animation
		player_animation = new Aval.Animation (player_texture, (uint16)PLAYER_WIDTH, (uint16)PLAYER_HEIGHT, 7, 0, 0, 4, {0, 0});
		
		// Set the player to be active
		active = true;
		
		// Set the player starting health
		health = 100;
		
		// Set a constant player move speed
		player_move_speed = 8.0f;
		
		// Set to no movement
		moving = {false};
		
		// Physics
		double moment = cp.moment_for_box (MASS, PLAYER_WIDTH, PLAYER_HEIGHT);
		body = new cp.Body (MASS, moment);
		space.add_body (body);
		int half_height = PLAYER_HEIGHT/2;
		shape = new cp.SegmentShape (body, {-PLAYER_WIDTH/2, -half_height}, {PLAYER_WIDTH*0.4f, half_height}, 0);
		space.add_shape (shape);
		// Set the starting position of the player around the middle of the screen and to the back
		body.set_pos ({start_position.x, start_position.y});
	}
	
	public void update (SDL.Event e) {		
		// Check Keyboard / Dpad
		if (e.type == SDL.EventType.KEYDOWN){
			if (e.key.keysym.sym == SDL.Keycode.LEFT) moving[0] = true;
			else if (e.key.keysym.sym == SDL.Keycode.RIGHT) moving[1] = true;
			else if (e.key.keysym.sym == SDL.Keycode.UP) moving[2] = true;
			else if (e.key.keysym.sym == SDL.Keycode.DOWN) moving[3] = true;
		}else if (e.type == SDL.EventType.KEYUP){
			if (e.key.keysym.sym == SDL.Keycode.LEFT) moving[0] = false;
			else if (e.key.keysym.sym == SDL.Keycode.RIGHT) moving[1] = false;
			else if (e.key.keysym.sym == SDL.Keycode.UP) moving[2] = false;
			else if (e.key.keysym.sym == SDL.Keycode.DOWN) moving[3] = false;
		}
		
		// Realize movement
		if (moving[0] == true) body.p.x -= player_move_speed;
		if (moving[1] == true) body.p.x += player_move_speed;
		if (moving[2] == true) body.p.y -= player_move_speed;
		if (moving[3] == true) body.p.y += player_move_speed;
		
		// Make sure that the player does not go out of bounds
		// TODO: Find a better method
		SDL.Point screen_size = {0};
		Aval.Game.WINDOW.get_size(out screen_size.x, out screen_size.y);
		if (body.p.x < 0)
			body.p.x = 0;
		if (body.p.x > screen_size.x)
			body.p.x = screen_size.x;
		if (body.p.y < 0)
			body.p.y = 0;
		if (body.p.y > screen_size.y)
			body.p.y = screen_size.y;
		
		// Update animation
		player_animation.screen_pos = {(int)body.p.x-(PLAYER_WIDTH/2), (int)body.p.y-(PLAYER_HEIGHT/2)};
		player_animation.tick ();
		player_animation.update_rects ();
	}
	
	public void draw () {
		// Draw the animation
		player_animation.draw ();
	}
} // Player


}// Shooter