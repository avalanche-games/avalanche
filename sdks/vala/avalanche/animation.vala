namespace Aval {

public class Animation {
	private unowned SDL.Texture spritesheet;
	public SDL.Point screen_pos;
	protected uint16 frame_width;
	protected uint16 frame_height;
	protected uint8 actual_x;
	protected uint8 actual_y;
	private uint8 last_x;
	private uint8 last_y;
	private SDL.Rect input;
	private SDL.Rect output;
	
	public Animation (SDL.Texture _spritesheet, uint16 _frame_width, uint16 _frame_height, uint8 last_frame_x, uint8 last_frame_y, uint8 start_frame_y) {
		this.spritesheet = _spritesheet;
		this.frame_width = _frame_width;
		this.frame_height = _frame_height;
		this.last_x = last_frame_x;
		this.last_y = last_frame_y;
		this.actual_y = start_frame_y;
		screen_pos = {0, 0};
	}
	
	public void set_x (uint8 nvalue) {
		actual_x = nvalue;
		while (actual_x > last_x)
			actual_x -= last_x;
	}
	
	public void next () {
		if (actual_x == last_x)
			actual_x = 0;
		else
			actual_x++;
		update_rects ();
	}
	
	public void set_y (uint8 nvalue) {
		actual_y = nvalue;
		while (actual_y > last_y)
			actual_y -= last_y;
	}
	
	public void update_rects () {
		input = {frame_width * actual_x, frame_height * actual_y, frame_width, frame_height};
		output = {screen_pos.x, screen_pos.y, frame_width, frame_height};
	}
	
	public void draw () {
		Aval.Game.WIN_RENDERER.copy (spritesheet, input, output);
	}
}// Animation


}// Aval