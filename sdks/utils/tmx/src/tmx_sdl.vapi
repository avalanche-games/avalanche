[CCode (cheader_filename = "tmx_sdl.h")]
namespace TMXSDL {
	[CCode (cname="set_color")]
	public static void set_color(SDL.Renderer ren, int color);
	
	[CCode (cname="draw_polyline")]
	public static void draw_polyline(SDL.Renderer ren, int **points, int x, int y, int pointsc);
	
	[CCode (cname="draw_polygon")]
	public static void draw_polygon(SDL.Renderer ren, int **points, int x, int y, int pointsc);
	
	[CCode (cname="draw_objects")]
	public static void draw_objects(SDL.Renderer ren, TMX.Object head, int color);
	
	[CCode (cname="gid_clear_flags")]
	public static int gid_clear_flags(uint gid);
	
	[CCode (cname="get_bitmap_region")]
	public static short get_bitmap_region(uint gid, TMX.Tileset ts, SDL.Surface *ts_bmp, uint *x, uint *y, uint *w, uint *h);
	
	[CCode (cname="draw_layer")]
	public static void draw_layer(SDL.Renderer ren, TMX.Layer layer, TMX.Tileset ts, uint width, uint height, uint tile_width, uint tile_height);
	
	[CCode (cname="draw_image_layer")]
	public static void draw_image_layer(SDL.Renderer ren, TMX.Image img);
	
	[CCode (cname="render_map")]
	public static SDL.Texture render_map(SDL.Renderer ren, TMX.Map map);
	
	[CCode (cname="tmxsdl_init")]
	public static void init();
}// TMXSDL