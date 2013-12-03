namespace Shooter {

public class Enemy  {
	// Animation representing the enemy
	unowned SDL.Texture enemy_texture;
	Aval.Animation enemy_animation;
	
	// State of the enemy ship
	public bool active;
	
	// The amount of damage the enemy inflicts on the player ship
	public int damage;
	
	// Amount of hit points that enemy has
	public int health;
	
	// The amount of score the enemy will give to the player
	public int val;
	
	// A movement speed for the enemy
	double enemy_move_speed;
	
	// Width and height of the enemy ship image
	public static const int ENEMY_WIDTH = 47;
	public static const int ENEMY_HEIGHT = 61;
	private static const int half_width = ENEMY_WIDTH/2;
	private static const int half_height = ENEMY_HEIGHT/2;
	
	// Physics
	public cp.Body body;
	public cp.SegmentShape shape;
	static const double MASS = 2;
	
	public Enemy (SDL.Texture enemy_texture, int screen_width, int screen_height, cp.Space space) {
		this.enemy_texture = enemy_texture;
		
		// Create enemy animation
		enemy_animation = new Aval.Animation (enemy_texture, (uint16)ENEMY_WIDTH, (uint16)ENEMY_HEIGHT, 7, 0, 0, 4, {0, 0});
		
		// Randomly generate the position of the enemy
		SDL.Point start_position = {screen_width, Main.RANDOM.int_range(0, screen_height)};
		
		// Set the enemy to be active
		active = true;
		
		// Set the amount of damage the enemy can do
		damage = 10;
		
		// Set the enemy starting health
		health = 10;
		
		// Set the score value of the enemy
		val = 100;
		
		// Set a constant enemy move speed
		enemy_move_speed = 6f;
		
		// Physics
		double moment = cp.moment_for_box (MASS, ENEMY_WIDTH, ENEMY_HEIGHT);
		body = new cp.Body (MASS, moment);
		body.set_pos ({start_position.x, start_position.y});
		space.add_body (body);
		shape = new cp.SegmentShape (body, {-half_width, -half_height}, {half_width, half_height}, 0);
		space.add_shape (shape);
	}
	
	public void update () {
		// The enemy always moves to the left so decrement it's xposition
		body.p.x -= enemy_move_speed;
		
		// If the enemy is past the screen or its health reaches 0 then deactivate it
		if (body.p.x < 0 || health <= 0) {
			// By setting the Active flag to false, the game will remove this objet from the active game list
			active = false;
		}
	
		// Update animation
		enemy_animation.screen_pos = {(int)body.p.x-(ENEMY_WIDTH/2), (int)body.p.y-(ENEMY_HEIGHT/2)};
		enemy_animation.tick ();
		enemy_animation.update_rects ();
	}
	
	public void draw () {
		// Draw the animation
		enemy_animation.draw ();
	}
	
	public void dispose () {
		enemy_animation = null;
	}
	
	public void physics_dispose (cp.Space space) {
		space.remove_body (this.body);
		space.remove_shape (this.shape);
		body = null;
		shape = null;
	}
} // Enemy


}// Shooter