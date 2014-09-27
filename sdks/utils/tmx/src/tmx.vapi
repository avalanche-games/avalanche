[CCode (cprefix = "tmx_", cheader_filename = "tmx.h")]
namespace TMX {
	
	[CCode (cname="TMX_FLIPPED_HORIZONTALLY")]
	public static const uint FLIPPED_HORIZONTALLY;
	[CCode (cname="TMX_FLIPPED_VERTICALLY")]
	public static const uint FLIPPED_VERTICALLY;
	[CCode (cname="TMX_FLIPPED_DIAGONALLY")]
	public static const uint FLIPPED_DIAGONALLY;
	[CCode (cname="TMX_FLIP_BITS_REMOVAL")]
	public static const uint FLIP_BITS_REMOVAL;
	
	[CCode (cname="tmx_map_orient", cprefix = "O_")]
	public enum MapOrient {
		NONE, ORT, ISO, STA
	}
	
	[CCode (cname="tmx_layer_type", cprefix = "L_")]
	public enum LayerType {
		NONE, LAYER, OBJGR, IMAGE
	}
	
	[CCode (cname="tmx_shape", cprefix = "S_")]
	public enum Shape {
		NONE, SQUARE, POLYGON, POLYLINE, ELLIPSE, TILE
	}
	
	[CCode (cname="tmx_property")]
	[SimpleType]
	public struct Property {
		string name;
		string value;
		//unowned TMX.Property next;
	}// Property
	
	[CCode (cname="tmx_image")]
	[SimpleType]
	public struct Image {
		string source;
		int trans;
		ulong width;
		ulong height;
		unowned SDL.Surface resource_image;
	}// Image
	
	[CCode (cname="tmx_tileset")]
	[SimpleType]
	public struct Tileset {
		uint firstgid;
		string name;
		uint tile_width;
		uint tile_height;
		uint spacing;
		uint margin;
		uint x_offset;
		uint y_offset;
		unowned TMX.Image image;
		unowned TMX.Property properties;
		//unowned TMX.Tileset next;
	}// Tileset
	
	[CCode (cname="tmx_object")]
	[SimpleType]
	public struct Object {
		string name;
		TMX.Shape shape;
		ulong x;
		ulong y;
		ulong width;
		ulong height;
		int gid;
		[CCode (array_length_cname="points_len", cname="points")]
		int[] points[2]; /* point[i][x,y]; x=0 y=1 */
		char visible;
		unowned TMX.Property properties;
		//unowned TMX.Object next;
	}// Object
	
	[CCode (cname="tmx_layer")]
	[SimpleType]
	public struct Layer {
		string name;
		int color;
		double opacity;
		char visible;
		
		TMX.LayerType type;
		[CCode (cname="content.head")]
		unowned TMX.Object head;
		[CCode (cname="content.image")]
		unowned TMX.Image image;
		
		void *user_data;
		unowned TMX.Property properties;
		//unowned TMX.Layer next;
	}// Layer
	
	[CCode (cname="tmx_map")]
	[Compact]
	public class Map {
		[CCode (cname="tmx_load")]
		public Map (string fpath);
		
		TMX.MapOrient orient;
		uint width;
		uint height;
		uint tile_width;
		uint tile_height;
		int backgroundcolor;
		
		unowned TMX.Property properties;
		unowned TMX.Tileset ts_head;
		unowned TMX.Layer ly_head;
	}// Map
	
	[CCode (cname="int", cprefix = "E_")]
	public enum _ErrorCodes {
		NONE,UNKN,INVAL,ALLOC,ACCESS,NOENT,FORMAT,ENCCMP,FONCT,BDATA,ZDATA,XDATA,JDATA,CDATA,MISSEL
	}
	
	[CCode (cname="tmx_errno")]
	public static TMX._ErrorCodes errno;
	
	[CCode (cname="tmx_perror")]
	public static void perror (string msg);
	
	[CCode (cname="tmx_strerr")]
	public static string strerr ();
	
}// TMX