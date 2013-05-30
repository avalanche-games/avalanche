namespace AvalancheTemplate {

public class SampleIMGState : Avalanche.ScreenState,  GLib.Object {
	private SDL.Texture sample_tex;
	
	public SampleIMGState () {
		// Things should not be loaded here
		sample_tex = null;
	}
	
        public void on_enter () {
		// Loads sample image and put on a texture.
		sample_tex = SDLImage.load_texture (Avalanche.Game.WIN_RENDERER, "./sample.png");
	}
	
	public void on_update () {
		// This is a static state, so this method is useless here
	}
	
	public void draw () {
		// Draw sample image
		Avalanche.Game.WIN_RENDERER.copy (sample_tex, null, null);
	}
	
	public void on_leave () {
		// Nothing to do here...
	}
	
	public void on_event (SDL.Event e) {
		// ... OH Yeah!
	}
}// SampleIMGState


}// AvalancheTemplate