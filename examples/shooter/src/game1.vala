namespace Shooter {

public class Game1 : Aval.ScreenState,  GLib.Object {
	// Represents the player 
	Player player;
	
	// Background
	SDL.Texture background_main;
	Aval.Parallaxed background_layer1;
	Aval.Parallaxed background_layer2;
	
	// Enemies
	SDL.Texture enemy_texture;
	Array<Enemy> enemies;
	
	// Projectiles
	SDL.Texture projectile_texture;
	Array<Projectile> projectiles;
	
	// Explosions
	SDL.Texture explosion_texture;
	Array<Aval.Animation> explosions;
	
	// The rate at which the enemies appear
	long next_enemy_spawn_time;
	long enemy_spawn_interval;
	
	// The rate of fire of the player laser
	long next_fire_time;
	long fire_interval;
	
	// Frame counter
	long frame_count;
	
	// The sound that is played when a laser is fired
	SDLMixer.Chunk laser_sound;
	
	// The sound used when the player or an enemy dies
	SDLMixer.Chunk explosion_sound;
	
	// The music played during gameplay
	SDLMixer.Music gameplay_music;
	
	//Number that holds the player score
	int score;
	
	// The font used to display UI elements
	SDLTTF.Font font;
	
	// Easiest way to render text
	Aval.Text score_text;
	Aval.Text health_text;
	
	// Width and height of the player ship image
	public static const uint16 EXPLOSION_WIDTH = 134;
	public static const uint16 EXPLOSION_HEIGHT = 134;
	
	// Physics
	cp.Space space;
	static const double TIME_STEP = 1.0/60.0;
	
	public void on_enter () {
		// Set initial values
		enemy_spawn_interval = 60;
		fire_interval = 8;
		score = 0;
		
		// Create an empty space.
		space = new cp.Space();
		
		// Load background
		background_main = SDLImage.load_texture (Aval.Game.WIN_RENDERER, "mainbackground.png");
		
		// Load the parallaxing background
		background_layer1 = new Aval.Parallaxed ("bgLayer1.png", Main.WW , -1, 0, Main.WH);
		background_layer2 = new Aval.Parallaxed ("bgLayer2.png", Main.WW , -2, 0, Main.WH);
		
		// Initialize the player class
		player = new Player ("shipAnimation.png", {Main.WW /2, Main.WH /2}, space);
		
		// Load enemy image file directly to texture
		enemy_texture = SDLImage.load_texture (Aval.Game.WIN_RENDERER, "mineAnimation.png");
		
		// Load projectile image file directly to texture
		projectile_texture = SDLImage.load_texture (Aval.Game.WIN_RENDERER, "laser.png");
		
		// Load explosion image file directly to texture
		explosion_texture = SDLImage.load_texture (Aval.Game.WIN_RENDERER, "explosion.png");
		
		// Create enemies array
		enemies = new Array<Enemy> ();
		
		// Create projectiles array
		projectiles = new Array<Projectile> ();
		
		// Create projectiles array
		explosions = new Array<Aval.Animation> ();
		
		// Load the music
		gameplay_music = new SDLMixer.Music ("gameMusic.mp3");
		
		// Load the laser and explosion sound effect
		laser_sound = new SDLMixer.Chunk.WAV ("laserFire.wav");
		explosion_sound = new SDLMixer.Chunk.WAV ("explosion.wav");
		
		// Start the music right away
		gameplay_music.play (-1);
		
		// Load the score font
		font = new SDLTTF.Font ("DroidSansMono.ttf", 18);
		
		// Score and health text renderer
		score_text = new Aval.Text (font, {255, 255, 255, 0}, {0, 0});
		health_text = new Aval.Text (font, {255, 255, 255, 0}, {0, 20});
		score_text.set_text ("WAITING ANY SCORE");
		health_text.set_text ("FULL HEALTH");
		
		// Intialize timers
		frame_count = 0;
		next_enemy_spawn_time = enemy_spawn_interval;
		next_fire_time = fire_interval;
	}
	
	public void on_update (SDL.Event e) {
		// Timers tick
		frame_count += 1;
		
		// Update player
		player.update (e);
		
		// Update the parallaxing background
		background_layer1.update ();
		background_layer2.update ();
		
		// Spawn a new enemy enemy  only every interval we set as the enemy_spawn_interval
		if (frame_count > next_enemy_spawn_time) {
			// Reset our current time
			next_enemy_spawn_time = frame_count + enemy_spawn_interval;
			
			// Add an Enemy
			add_enemy ();
		}
		
		// Fire only every interval we set as the fire_interval
		if (frame_count > next_fire_time) {
			// Reset our current time
			next_fire_time = frame_count + fire_interval;
			
			// Add the projectile
			add_projectile();
		}
		
		// Update Explosions
		for (int i = (int)explosions.length - 1; i >= 0; i--) {
			unowned Aval.Animation ep = explosions.index (i);
			
			// Removed explosion on animation end
			if (ep.get_x () == 7)
				explosions.remove_index (i);
			
			// Update animation
			else {
				ep.tick ();
				ep.update_rects ();
			}
		}
		
		// Update the Enemies
		for (int i = (int)enemies.length - 1; i >= 0; i--) {
			unowned Enemy en = enemies.index (i);
			en.update ();
			
			if (en.active == false) {
				// If not active and health <= 0
				if (en.health <= 0) {
					// Add an explosion
					add_explosion({(int)en.body.p.x - EXPLOSION_WIDTH / 2,
						(int)en.body.p.y - EXPLOSION_HEIGHT / 2});
						
					// Add to the player's score
					score += en.val;
					score_text.set_text ("SCORE: %i".printf (score));
				}
					
				// Remove body from space
				en.physics_dispose (space);
				
				// Free memory
				en.dispose ();
				
				enemies.remove_index (i);
			}
		}
		
		// Update the Projectiles
		for (int i = (int)projectiles.length - 1; i >= 0; i--) {
			unowned Projectile pj = projectiles.index (i);
			pj.update ();
			
			if (pj.active == false) {
				// Remove body from space
				pj.physics_dispose (space);
				
				projectiles.remove_index (i);
			}
		}
		
		// Physics step forward
		for(double time = 0; time < 2; time += TIME_STEP){
			space.step (TIME_STEP);
		}
		
		// Update the collision MANUALLY
		update_collisions ();
	}
	
	public void draw () {		
		// Draw the background
		Aval.Game.WIN_RENDERER.copy (background_main,
			{0, 0, background_layer1.texture_width, background_layer1.texture_height},
			{0, 0, Main.WW, background_layer1.force_height});
		
		// Draw the moving background
		background_layer1.draw ();
		background_layer2.draw ();
		
		// Draw the enemies
		for (int i = 0; i < enemies.length; i++)
			enemies.index (i).draw ();
		
		// Draw the projectiles
		for (int i = 0; i < projectiles.length; i++)
			projectiles.index (i).draw ();
		
		// Draw the explosions
		for (int i = 0; i < explosions.length; i++)
			explosions.index (i).draw ();
		
		// Draw the Player
		player.draw ();
			
		// Draw the score
		score_text.draw ();
		
		// Draw the player health
		health_text.draw ();
	}
	
	public void on_leave () {
		// My mon said that I should clean all my own dirty
		// - Vala is smart and do A LOT of those automatically, but nothing better than be precautious
		player.physics_dispose (space);
		player.dispose ();
		player = null;
		
		for (int i = (int)enemies.length - 1; i >= 0; i--) {
			unowned Enemy en = enemies.index (i);
			en.physics_dispose (space);
			en.dispose ();
			enemies.remove_index (i);
		}
		enemies = null;
		
		for (int i = (int)projectiles.length - 1; i >= 0; i--) {
			unowned Projectile pj = projectiles.index (i);
			pj.physics_dispose (space);
			projectiles.remove_index (i);
		}
		projectiles = null;
		
		space = null;
		
		background_main = null;
		background_layer1.dispose ();
		background_layer2.dispose ();
		background_layer1 = null;
		background_layer2 = null;
		
		enemy_texture = null;
		explosion_texture = null;
		
		laser_sound = null;
		explosion_sound = null;
		gameplay_music = null;
		
		score_text = null;
		health_text = null;
		
		font = null;
		
		explosions = null;
	}
	
	private void add_enemy () {
		// Create an enemy, intialize and add to the enemies list
		enemies.append_val (new Enemy (enemy_texture, Main.WW, Main.WH, space));
	}
	
	public void add_projectile () {
		// Create an projectile, intialize and add to the active list,
		// but add it to the front and center of the player
		projectiles.append_val (new Projectile (projectile_texture,
			{(int)player.body.p.x + (Player.PLAYER_WIDTH / 2), (int)player.body.p.y},
			space));
		
		// Play the laser sound
		SDLMixer.DEFAULT_CHANNEL.play (laser_sound, 0);
	}
	
	public void add_explosion (SDL.Point pos) {
		explosions.append_val (new Aval.Animation (explosion_texture,
			EXPLOSION_WIDTH, EXPLOSION_HEIGHT, 11, 0, 0, 1, pos));
		
		// Play the explosion sound
		SDLMixer.DEFAULT_CHANNEL.play (explosion_sound, 0);
	}
	
	private void update_collisions () {
		// Do the collision between the player and the enemies
		for (int i = 0; i < (int)enemies.length; i++) {
			unowned Enemy en = enemies.index (i);
			
			// Determine if the two objects collided with each other
			if (player.shape.bb.intersects (en.shape.bb)) {
				// Subtract the health from the player based on the enemy damage
				player.health -= en.damage;
				health_text.set_text ("HEALTH: %d".printf (player.health));
				
				// Since the enemy collided with the player destroy it
				en.health = 0;
				
				// If the player health is less than zero we died
				if (player.health <= 0) {
					Aval.Game.change_state (new Splash ("endMenu.png", null));
					return; // Important
				}
			}
			
			// Projectile vs Enemy Collision
			for (int j = 0; j < (int)projectiles.length; j++) {
				unowned Projectile pj = projectiles.index (j);
				
				// Determine if the two objects collided with each other
				if (pj.shape.bb.intersects (en.shape.bb)) {
					en.health -= pj.damage;
					pj.active = false; 
				}
			}
		}
	}
}// Game1


}// Shooter