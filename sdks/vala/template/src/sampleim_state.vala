namespace AvalancheTemplate {

public class SampleIMGState : Aval.ScreenState,  GLib.Object {
	private SDL.Texture sample_tex;
	
	public SampleIMGState () {
		// Things should not be loaded here
		sample_tex = null;
	}
	
        public void on_enter () {
		// Loads sample image and put on a texture.
		sample_tex = SDLImage.load_texture (Aval.Game.WIN_RENDERER, "../res/sample.png");
	}
	
	public void on_update (SDL.Event e) {
	}
	
	public void draw () {
		Aval.Game.WIN_RENDERER.copy (sample_tex, null, null);
	}
	
	public void on_leave () {
		// GCC please, destroy sample_tex for us *-*
	}
}// SampleIMGState


}// AvalancheTemplate