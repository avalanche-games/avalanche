namespace Shooter {

public class Splash : Aval.ScreenState,  GLib.Object {
	SDL.Texture background;
	uint frame_count;
	static const double FADE_PERFRAME = 255 / 120;
	double alpha;
	Aval.ScreenState? next_state;
	string bg_path;
	
	public Splash (string bg_path, Aval.ScreenState? next_state) {
		this.next_state = next_state;
		this.bg_path = bg_path;
	}
	
	public void on_enter () {
		background = SDLImage.load_texture (Aval.Game.WIN_RENDERER, bg_path);
		background.set_blend_mod (SDL.BlendMode.BLEND);
		frame_count = 0;
		alpha = 0;
	}
	
	public void on_update (SDL.Event e) {
		if (frame_count == 360) {
			Aval.Game.change_state (next_state);
			return;
		} else if (frame_count < 120) { // Fade in
			alpha += FADE_PERFRAME;
		} else if (frame_count > 239) { // Fade out
			alpha -= FADE_PERFRAME;
		} else
			alpha = 255;
		
		if (alpha >= 255)
			alpha = 255;
		else if (alpha <= 0)
			alpha = 0;
		
		background.set_alpha_mod ((uint8) alpha);
		
		frame_count++;
	}
	
	static const SDL.Rect rect = {0, 0, 840, 480};
	public void draw () {
		Aval.Game.WIN_RENDERER.copy (background, rect, rect);
	}
	
	public void on_leave () {
		// Let's be good boys and free memory by ourselves
		background = null;
	}
} // End

}// Shooter