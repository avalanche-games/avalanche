namespace AvalancheTemplate {

public class SampleIMGState : Aval.ScreenState,  GLib.Object {
	private SDL.Graphics.Texture sample_tex;
	
	public SampleIMGState () {
		// Things should not be loaded here
		sample_tex = null;
	}
	
        public void on_enter () {
		// Loads sample image and put on a texture.
		sample_tex = SDLImage.load_texture (Aval.Game.WIN_RENDERER, "sample.png");
	}
	
	public void on_event (SDL.Event e) {
	}
	
	public void on_update () {
	}
	
	public void draw () {
		Aval.Game.WIN_RENDERER.copy (sample_tex, null, null);
	}
	
	public void on_leave () {
		// GCC please, destroy sample_tex for us *-*
	}
}// SampleIMGState


}// AvalancheTemplate