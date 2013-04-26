namespace Avalanche {

public enum PosCorner {
	TOP_LEFT, TOP_RIGHT,
	BOTTOM_LEFT, BOTTOM_RIGHT
}// PosCorner


// ScreenPosition is a helper and code shortcut to avoid reptissions
public class ScreenPosition {
	public uint16 x;
	public uint16 y;
	
	public ScreenPosition.from_exactly(uint16 x, uint16 y) {
		this.x = x;
		this.y = y;
	}
	
	public ScreenPosition.from_corners(uint16 x, uint16 y, PosCorners corner) {
		switch(corner){
			case  PosCorner.TOP_LEFT:
				this.x = x;
				this.y = y;
				break;
			case  PosCorner.TOP_RIGHT:
				this.x = Avalanche.Game.video_w - x;
				this.y = y;
				break;
			case  PosCorner.BOTTOM_LEFT:
				this.x = x;
				this.y = Avalanche.Game.video_h - y;
				break;
			case  PosCorner.BOTTOM_RIGHT:
				this.x = Avalanche.Game.video_w - x;
				this.y = Avalanche.Game.video_h - y;
				break;
		}
	}
	
	public ScreenPosition.from_centralizedx(uint16 central_x, uint16 y, uint16 width) {
		this.x = central_x - (width / 2);
		this.y = y;
	}
	
	public ScreenPosition.from_centralizedy(uint16 x, uint16 central_y, uint16 height) {
		this.x = x;
		this.y = central_y - (height / 2);
	}
	
	public ScreenPosition.from_centralized(uint16 central_x, uint16 central_y, uint16 width, uint16 height) {
		this.x = central_x - (width / 2);
		this.y = central_y - (height / 2);
	}
	
	public void move(uint16 x, uint16 y) {
		this.x += x;
		this.y += y;
	}
	
	public void move_x(uint16 x) {
		this.x += x;
	}
	
	public void move_y(uint16 y) {
		this.y += y;
	}
}// ScreenPosition


// Sprite automates image loading and drawning
public class Sprite {
	//TODO: Choose between this or just store pixels...
	public SDL.Surface? bitmap;
	/* OpenGL Texture ID
	 * [GLuint] Unsigned binary integer(min. 32 bits)
	 */
	public uint32 texture;
	public ScreenPosition? position;
	public int8 z = 0;
	
	public Sprite.load(string file) {
	}
	
	public Sprite.clone_surface(SDL.Surface origin) {
	}
	
	public void dispose_bitmap() {
	}
	
	public void free_texture() {
	}
	
	public void update(){
		//Copy surface to texture
	}
	
	public void update_rect(SDL.Rect rect){
	}
	
	//TODO: Finish PLANNING this class
}// Sprite


}// Avalanche