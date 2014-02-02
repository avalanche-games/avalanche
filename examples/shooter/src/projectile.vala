namespace Shooter {

public class Projectile : GLib.Object {
	// Image representing the Projectile
	unowned SDL.Texture texture;
	
	// State of the Projectile
	public bool active;
	
	// The amount of damage the projectile can inflict to an enemy
	public int damage;
	
	// A movement speed for the enemy
	double projectile_move_speed;
	
	// Width and height of the projectile image
	public static const int PROJECTILE_WIDTH = 46;
	public static const int PROJECTILE_HEIGHT = 16;
	public static const SDL.Rect projectile_irect = {0, 0, PROJECTILE_WIDTH, PROJECTILE_HEIGHT};
	
	// Physics
	public cp.Body body;
	public cp.SegmentShape shape;
	static const double MASS = 2;
	
	public Projectile (SDL.Texture texture, SDL.Point start_position, cp.Space space) {
		this.texture = texture;
		
		// Set the projectile to be active
		active = true;
		
		// Set the amount of damage the projectile can do
		damage = 2;
		
		// Set a constant projectile move speed
		projectile_move_speed = 20f;
		
		// Physics
		double moment = cp.moment_for_box (MASS, PROJECTILE_WIDTH, PROJECTILE_HEIGHT);
		body = new cp.Body (MASS, moment);
		body.set_pos ({start_position.x, start_position.y});
		space.add_body (body);
		int half_width = PROJECTILE_WIDTH/2;
		int half_height = PROJECTILE_HEIGHT/2;
		shape = new cp.SegmentShape (body, {-half_width, -half_height}, {half_width, half_height}, 0);
		space.add_shape (shape);
	}
	
	public void update () {
		// Projectiles always move to the right
		body.p.x += projectile_move_speed;
		
		// Deactivate the bullet if it goes out of screen
		if (body.p.x + PROJECTILE_WIDTH / 2 > Aval.Game.WW)
			active = false;
	}
	
	public void draw () {
		Aval.Game.WIN_RENDERER.copy (texture, projectile_irect,
			{(int)body.p.x - PROJECTILE_WIDTH / 2, (int)body.p.y - PROJECTILE_HEIGHT / 2,
			PROJECTILE_WIDTH, PROJECTILE_HEIGHT});
	}
	
	public void physics_dispose (cp.Space space) {
		space.remove_body (this.body);
		space.remove_shape (this.shape);
		body = null;
		shape = null;
	}
} // Projectile


}// Shooter