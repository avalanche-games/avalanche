namespace Shooter {

public class Player {
	// Animation representing the player
	SDL.Texture player_texture;
	Aval.Animation player_animation;
	
	// Amount of hit points that player has
	public int health;
	
	// A movement speed for the player
	double player_move_speed;
	
	// Movemet holder
	bool moving[4];
	int touch_move[2];
	
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
	
	public void on_event (SDL.Event e) {	
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
		}else if (e.type == SDL.EventType.FINGERMOTION ||
			e.type == SDL.EventType.FINGERDOWN){
			double fx = Math.round((double)e.tfinger.x * (double)Aval.Game.WW);
			double fy = Math.round((double)e.tfinger.y * (double)Aval.Game.WH);
			
			if(fx < body.p.x) touch_move[0]= -(int)player_move_speed;
			else if(fx > body.p.x) touch_move[0]= (int)player_move_speed;
			
			if (((int)(fx - body.p.x)).abs () < player_move_speed && touch_move[0] != 0)
				touch_move[0] =  (fx < body.p.x ? (int)(fx - body.p.x) : (int)(body.p.x - fx));
			
			else if(fy < body.p.y) touch_move[1]= -(int)player_move_speed;
			else if(fy > body.p.y) touch_move[1]= (int)player_move_speed;
			
			if (((int)(fy - body.p.y)).abs () < player_move_speed && touch_move[1] != 0)
				touch_move[1] =  (fy < body.p.y ? (int)(fy - body.p.y) : (int)(body.p.y - fy));
		}else if (e.type == SDL.EventType.FINGERUP) {
			touch_move = {0};
		}
	}
	
	public void update () {
		// Realize movement
		if (touch_move[0] != 0)
			body.p.x += touch_move[0];
		else {
			if (moving[0] == true) body.p.x -= player_move_speed;
			if (moving[1] == true) body.p.x += player_move_speed;
		}
		
		if (touch_move[0] != 0)
			body.p.y += touch_move[1];
		else {
			if (moving[2] == true) body.p.y -= player_move_speed;
			if (moving[3] == true) body.p.y += player_move_speed;
		}
		
		// Make sure that the player does not go out of bounds
		if (body.p.x < 0)
			body.p.x = 0;
		if (body.p.x > Aval.Game.WW)
			body.p.x = Aval.Game.WW;
		if (body.p.y < 0)
			body.p.y = 0;
		if (body.p.y > Aval.Game.WH)
			body.p.y = Aval.Game.WH;
		
		// Update animation
		player_animation.screen_pos = {(int)body.p.x-(PLAYER_WIDTH/2), (int)body.p.y-(PLAYER_HEIGHT/2)};
		player_animation.tick ();
		player_animation.update_rects ();
	}
	
	public void draw () {
		// Draw the animation
		player_animation.draw ();
	}
	
	public void dispose () {
		player_texture = null;
		player_animation = null;
	}
	
	public void physics_dispose (cp.Space space) {
		space.remove_body (this.body);
		space.remove_shape (this.shape);
		body = null;
		shape = null;
	}
} // Player


}// Shooter