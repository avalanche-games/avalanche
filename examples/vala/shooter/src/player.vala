namespace Shooter {

public class Player {
	// Animation representing the player
	SDL.Texture player_texture;
	Aval.Animation player_animation;
	
	// Position of the player relative to the top left corner of thescreen
	//SDL.Point position;
	
	// State of the player
	public bool active;
	
	// Amount of hit points that player has
	public uint health;
	
	// A movement speed for the player
	double player_move_speed;
	
	// Movemet holder
	bool moving[4];
	
	// Width and height of the player ship image
	const int player_width = 115;
	const int player_height = 69;
	
	// Physics
	private cp.Body body;
	private cp.SegmentShape shape;
	static const double MASS = 5;
	
	public Player (string texture_path, SDL.Point start_position, cp.Space space) {
		// Load player ship image file directly to texture
		player_texture = SDLImage.load_texture (Aval.Game.WIN_RENDERER, texture_path);
		
		// Create player animation
		player_animation = new Aval.Animation (player_texture, (uint16)player_width, (uint16)player_height, 7, 0, 0, 4, {0, 0});
		
		// Set the starting position of the player around the middle of the screen and to the back
		//position = start_position;
		
		// Set the player to be active
		active = true;
		
		// Set the player starting health
		health = 100;
		
		// Set a constant player move speed
		player_move_speed = 8.0f;
		
		// Set to no movement
		moving = {false};
		
		// Physics
		double moment = cp.moment_for_box (MASS, player_width, player_height);
		body = new cp.Body (MASS, moment);
		body.set_pos ({start_position.x, start_position.y});
		space.add_body (body);
		shape = new cp.SegmentShape (body, {0, 0}, {player_width, player_height}, 0);
		space.add_shape (shape);
	}
	
	public void update (SDL.Event e) {		
		// Use the Keyboard / Dpad
		// TODO: Make it smoother
		if (e.type == SDL.EventType.KEYDOWN)
			if (e.key.keysym.sym == SDL.Keycode.LEFT)
				body.p.x -= player_move_speed;
			else if (e.key.keysym.sym == SDL.Keycode.RIGHT)
				body.p.x += player_move_speed;
			else if (e.key.keysym.sym == SDL.Keycode.UP)
				body.p.y -= player_move_speed;
			else if (e.key.keysym.sym == SDL.Keycode.DOWN)
				body.p.y += player_move_speed;
		
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
		player_animation.screen_pos = {(int)body.p.x-(player_width/2), (int)body.p.y-(player_height/2)};
		player_animation.tick ();
		player_animation.update_rects ();
	}
	
	public void draw () {
		// Draw the animation
		player_animation.draw ();
	}
} // Player


}// Shooter