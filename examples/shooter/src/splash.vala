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
		set_outrect ();
	}
	
	public void on_event (SDL.Event e) {
		if (e.type == SDL.EventType.WINDOWEVENT &&
			e.window.event == SDL.WindowEventID.RESIZED)
			set_outrect ();
	}
	
	public void on_update () {
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
	
	static const SDL.Rect inrect = {0, 0, 840, 480};
	static SDL.Rect outrect;
	public void draw () {
		Aval.Game.WIN_RENDERER.copy (background, inrect, outrect);
	}
	
	private void set_outrect () {
		// Do not make image larger than it is.
		int secure_width = (Aval.Game.WW <= inrect.w ? Aval.Game.WW : inrect.w);
		
		// Keeps aspect ratio
		int proportional_height = (int)Math.round(
			(double)inrect.h / (double)inrect.w * (double)secure_width
			);
		outrect = {(Aval.Game.WW - secure_width) / 2,
			(Aval.Game.WH - proportional_height) / 2,
			secure_width,
			proportional_height};
	}
	
	public void on_leave () {
		// Let's be good boys and free memory by ourselves
		background = null;
	}
} // End

}// Shooter