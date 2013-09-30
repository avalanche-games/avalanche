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
	
	// The rate at which the enemies appear
	int64 next_enemy_spawn_time;
	
	// Physics
	cp.Space space;
	static const double TIME_STEP = 1.0/60.0;
	
	public void on_enter () {
		// Get screen info
		SDL.Point screen_size = {0};
		Aval.Game.WINDOW.get_size(out screen_size.x, out screen_size.y);
		
		// Create an empty space.
		space = new cp.Space();
		
		// Load background
		background_main = SDLImage.load_texture (Aval.Game.WIN_RENDERER, "../res/mainbackground.png");
		
		// Load the parallaxing background
		background_layer1 = new Aval.Parallaxed ("../res/bgLayer1.png", screen_size.x , -1, 0, screen_size.y);
		background_layer2 = new Aval.Parallaxed ("../res/bgLayer2.png", screen_size.x , -2, 0, screen_size.y);
		
		// Initialize the player class
		player = new Player ("../res/shipAnimation.png", {screen_size.x /2, screen_size.y /2}, space);
		
		// Load player enemy image file directly to texture
		enemy_texture = SDLImage.load_texture (Aval.Game.WIN_RENDERER, "../res/mineAnimation.png");
		
		// Create enemies array
		enemies = new Array<Enemy> ();
		
		// Set next enemy spawn time
		next_enemy_spawn_time = new DateTime.now_local ().add_seconds (1).to_unix ();
	}
	
	public void on_update (SDL.Event e) {
		// Update player
		player.update (e);
		
		// Update the parallaxing background
		background_layer1.update ();
		background_layer2.update ();
		
		// Spawn a new enemy enemy every 1.5 seconds
		int64 now_time = new DateTime.now_local ().to_unix ();
		if (now_time > next_enemy_spawn_time) {
			next_enemy_spawn_time = new DateTime.now_local ().add_seconds (1).to_unix ();
			
			// Add an Enemy
			add_enemy ();
		}
		
		// Update the Enemies
		for (int i = (int)enemies.length - 1; i >= 0; i--) {
			(enemies.index (i)).update ();
			
			if ((enemies.index (i)).active == false)
				enemies.remove_index (i);
		}
		
		// Physics step forward
		space.step (TIME_STEP);
	}
	
	public void draw () {		
		// Draw the background
		Aval.Game.WIN_RENDERER.copy (background_main,
			{0, 0, background_layer1.texture_width, background_layer1.texture_height},
			{0, 0, background_layer1.texture_width, background_layer1.force_height});
		
		// Draw the moving background
		background_layer1.draw ();
		background_layer1.draw ();
		
		// Draw the Enemies
		for (int i = 0; i < enemies.length; i++)
			(enemies.index (i)).draw ();
		
		// Draw the Player
		player.draw ();
	}
	
	public void on_leave () {}
	
	private void add_enemy () {
		// Create an enemy, intialize and add to the active enemies list
		enemies.append_val (new Enemy (enemy_texture,
			background_layer1.texture_width, background_layer1.force_height,
			space));
	}
}// Game1


}// AvalancheTemplate