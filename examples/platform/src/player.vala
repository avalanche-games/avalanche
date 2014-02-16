namespace Platform {

public class Player {
	// Animation representing the player
	SDL.Texture player_texture;
	Aval.Animation player_animation;
	
	// Amount of hit points that player has
	public int health;
	
	// A movement speed for the player
	double player_move_speed;
	
	// Movemet holder
	bool moving[2];
	bool attacking;
	bool guarding;
	bool jumping;
	
	// Player template info
	public static const string PLAYER_IMG = "skel.png";
	public static const int PLAYER_WIDTH = 32;
	public static const int PLAYER_HEIGHT = 64;
	
	// Animations masks
	public static const Aval.AnimationMask AN_IDLE = {0, 0, 0};
	public static const Aval.AnimationMask AN_WALK = {0, 1, 6};
	public static const Aval.AnimationMask AN_CROUCH = {0, 7, 9};
	public static const Aval.AnimationMask AN_STAND = {1, 0, 0};
	public static const Aval.AnimationMask AN_DMG_H = {1, 1, 2};
	public static const Aval.AnimationMask AN_DMG_L = {1, 3, 4};
	public static const Aval.AnimationMask AN_DMG_C = {1, 5, 6};
	public static const Aval.AnimationMask AN_JUMP = {1, 7, 9};
	public static const Aval.AnimationMask AN_VSTRIKE_S = {2, 0, 6};
	public static const Aval.AnimationMask AN_VSTRIKE_C = {3, 0, 6};
	public static const Aval.AnimationMask AN_VSTRIKE_A = {4, 4, 6};
	public static const Aval.AnimationMask AN_HSTRIKE_S = {2, 4, 6};
	public static const Aval.AnimationMask AN_HSTRIKE_C = {3, 4, 6};
	public static const Aval.AnimationMask AN_HSTRIKE_A = {4, 4, 6};
	public static const Aval.AnimationMask AN_PUNCH_S = {2, 7, 8};
	public static const Aval.AnimationMask AN_PUNCH_C = {3, 7, 8};
	public static const Aval.AnimationMask AN_PUNCH_A = {4, 7, 8};
	public static const Aval.AnimationMask AN_GUARD_S = {2, 9, 9};
	public static const Aval.AnimationMask AN_GUARD_C = {3, 9, 9};
	public static const Aval.AnimationMask AN_GUARD_A = {4, 9, 9};
	
	// Physics
	public cp.Body body;
	public cp.PolyShape shape;
	static const double MASS = 4;
	
	public Player (SDL.Point start_position, cp.Space space) {
		// Load player ship image file directly to texture
		player_texture = SDLImage.load_texture (Aval.Game.WIN_RENDERER, PLAYER_IMG);
		
		// Create player animation
		player_animation = new Aval.Animation (player_texture, (uint16)PLAYER_WIDTH, (uint16)PLAYER_HEIGHT, 9, 5, 0, 8, {0, 0});
		player_animation.set_mask (AN_IDLE);
		
		// Set the player starting health
		health = 100;
		
		// Set a constant player move speed
		player_move_speed = 2.0f;
		
		// Set to no movement
		moving = {false};
		attacking = false;
		guarding = false;
		
		// Physics
		body = new cp.Body (MASS, cp.INFINITY_MOMENT);
		space.add_body (body);
		shape = new cp.PolyShape (body, {
			cp.Vect(0, 0),
			cp.Vect(0, PLAYER_HEIGHT),
			cp.Vect(PLAYER_WIDTH, PLAYER_HEIGHT),
			cp.Vect(PLAYER_WIDTH, 0)
		}, {0});
		shape.u = 0.7;
		space.add_shape (shape);
		
		// Set the starting position of the player around the middle of the screen and to the back
		body.set_pos ({start_position.x-(PLAYER_WIDTH/2), start_position.y-(PLAYER_WIDTH/2)});
	}
	
	public void on_event (SDL.Event e) {	
		// Check Keyboard / Dpad
		if (e.type == SDL.EventType.KEYDOWN){
			if (e.key.keysym.sym == SDL.Keycode.LEFT || e.key.keysym.sym == SDL.Keycode.a){
				player_animation.flip = SDL.RendererFlip.HORIZONTAL;
				if(!moving[0]) player_animation.set_mask (AN_WALK);
				moving[0] = true;
				attacking = false;
			}
			else if (e.key.keysym.sym == SDL.Keycode.RIGHT || e.key.keysym.sym == SDL.Keycode.d){
				player_animation.flip = SDL.RendererFlip.NONE;
				if(!moving[1]) player_animation.set_mask (AN_WALK);
				moving[1] = true;
				attacking = false;
			}
			else if (e.key.keysym.sym == SDL.Keycode.LSHIFT){
				if(!attacking) player_animation.set_mask (AN_PUNCH_S);
				moving = {false};
				attacking = true;
			}
			else if (e.key.keysym.sym == SDL.Keycode.LALT){
				if(!guarding) player_animation.set_mask (AN_GUARD_S);
				moving = {false};
				attacking = false;
				guarding = true;
			}
			else if (e.key.keysym.sym == SDL.Keycode.SPACE){
				if(!jumping) {
					body.apply_impulse({0, -20}, {0});
					player_animation.set_mask (AN_JUMP);
				}
				moving = {false};
				attacking = false;
				guarding = false;
				jumping = true;
			}
		}else if (e.type == SDL.EventType.KEYUP){
			if (e.key.keysym.sym == SDL.Keycode.LEFT || e.key.keysym.sym == SDL.Keycode.a){
				if(moving[0] && !moving[1]) player_animation.set_mask (AN_IDLE);
				moving[0] = false;
			}
			else if (e.key.keysym.sym == SDL.Keycode.RIGHT || e.key.keysym.sym == SDL.Keycode.d){
				if(moving[1] && !moving[0]) player_animation.set_mask (AN_IDLE);
				moving[1] = false;
			}
			else if (e.key.keysym.sym == SDL.Keycode.LSHIFT){
				if(attacking && !moving[0] && !moving[1] && !guarding) player_animation.set_mask (AN_IDLE);
				attacking = false;
			}
			else if (e.key.keysym.sym == SDL.Keycode.LALT){
				if(guarding && !moving[0] && !moving[1] && !attacking) player_animation.set_mask (AN_IDLE);
				guarding = false;
			}
			else if (e.key.keysym.sym == SDL.Keycode.SPACE){
				if(jumping && !moving[0] && !moving[1] && !attacking && !guarding) player_animation.set_mask (AN_IDLE);
				jumping = false;
			}
		}
	}
	
	public void update () {
		if (moving[0] == true) body.p.x -= player_move_speed;
		if (moving[1] == true) body.p.x += player_move_speed;
		
		// Update animation
		// Angle (converted from radians to degrees)
		player_animation.angle = body.a*57.29578;
		player_animation.screen_pos = {(int)body.p.x, (int)body.p.y}; //TO BE ADJUSTED TO VIEWPORT //TODO
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


}// Platform