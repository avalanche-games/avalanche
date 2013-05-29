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
	
	public ScreenPosition.from_corners(uint16 x, uint16 y, PosCorner corner, uint16 maxw, uint16 maxh) {
		//Game.window.get_size(out maxw, out maxh);
		switch(corner){
			case  PosCorner.TOP_LEFT:
				this.x = x;
				this.y = y;
				break;
			case  PosCorner.TOP_RIGHT:
				this.x = maxw - x;
				this.y = y;
				break;
			case  PosCorner.BOTTOM_LEFT:
				this.x = x;
				this.y = maxh - y;
				break;
			case  PosCorner.BOTTOM_RIGHT:
				this.x = maxw - x;
				this.y = maxh - y;
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


}// Avalanche