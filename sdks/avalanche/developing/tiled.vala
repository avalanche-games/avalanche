/*
 *  This Source Code Form is subject to the terms of the Mozilla Public
 *  License, v. 2.0. If a copy of the MPL was not distributed with this
 *  file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 *                          Copyright(C) 2013
 *                   Christian Ferraz Lemos de Sousa
 *                      Pedro Henrique Lara Campos
 *
 *  Ported from libtiled-java. Original code authors rights:
 * Copyright 2004-2010, Thorbjørn Lindeijer <thorbjorn@lindeijer.nl>
 * Copyright 2004-2006, Adam Turk <aturk@biggeruniverse.com>
 *
 *  "Properties" not supported
 */
 
namespace Tiled {

/**
* The Map class is the focal point of the tiled.core package.
*/
public class Map {
	public static final int ORIENTATION_ORTHOGONAL = 1;
	public static final int ORIENTATION_ISOMETRIC = 2;
	public static final int ORIENTATION_HEXAGONAL = 4;
	// Shifted (used for iso and hex).
	public static final int ORIENTATION_SHIFTED = 5;
	
	public ArrayList<MapLayer> layers;
	public ArrayList<TileSet> tile_sets;
	
	public int tile_width;
	public int tile_height;
	public int orientation = ORIENTATION_ORTHOGONAL;
	public string filename;
	// Bounds in tiles
	public SDL.Rect bounds;
	
	/**
	* @param width  the map width in tiles.
	* @param height the map height in tiles.
	*/
	public Map (int width, int height) {
		layers = new ArrayList<MapLayer> ();
		bounds = {0, 0, width, height};
		tile_sets  = new ArrayList<TileSet> ();
	}
	
	/**
	* Changes the bounds of this plane to include all layers completely.
	*/
	public void fit_bounds_to_layers () {
		int width = 0;
		int height = 0;
		
		SDL.Rect layer_bounds = {0};
		
		for (int i = 0; i < layers.length; i++) {
			layers.index (i).bounds (layer_bounds);
			if (width < layer_bounds.w) width = layer_bounds.w;
			if (height < layer_bounds.h) height = layer_bounds.h;
		}
		
		bounds.w = width;
		bounds.h = height;
	}
	
	/**
	* Returns a Rectangle representing the maximum bounds in
	* tiles.
	* @return a new rectangle containing the maximum bounds of this plane
	*/
	public SDL.Rect getBounds () {
		return bounds;
	}
	
	public MapLayer add_layer (MapLayer layer) {
		layer.map = this;
		layers.add (layer);
		return layer;
	}

	public void set_layer (int index, MapLayer layer) {
		layer.map = this;
		// Needing to see if this is really the better way to update one value // TODO
		layers.set (index, layer);
	}

	public void insert_layer(int index, MapLayer layer) {
		layer.map = this;
		layers.insert (index, layer);
	}
	
	/**
	* Removes the layer at the specified index. Layers above this layer will
	* move down to fill the gap.
	*
	* @param index the index of the layer to be removed
	* @return the layer that was removed from the list
	*/
	public MapLayer remove_layer (int index) {
		return layers.remove_at (index);
	}

	/**
	* Removes all layers from the plane.
	*/
	public void remove_all_layers () {
		layers.remove_range (0, layers.length);
	}
	
	/**
	* Resizes this plane. The (dx, dy) pair determines where the original
	* plane should be positioned on the new area. Only layers that exactly
	* match the bounds of the map are resized, any other layers are moved by
	* the given shift.
	*
	* @see tiled.core.MapLayer#resize
	*
	* @param width  The new width of the map.
	* @param height The new height of the map.
	* @param dx     The shift in x direction in tiles.
	* @param dy     The shift in y direction in tiles.
	*/
	public void resize (int width, int height, int dx, int dy) {
		foreach (MapLayer layer in layers)
			if (layer.bounds.is_equal (bounds))
				layer.resize (width, height, dx, dy);
			else
				layer.set_offset (layer.bounds.x + dx, layer.bounds.y + dy);

		bounds.w = width;
		bounds.h = height;
	}
	
	/**
	* Determines whether the point (x,y) falls within the plane.
	*
	* @param x
	* @param y
	* @return true if the point is within the plane, false otherwise.
	*/
	public boolean in_bounds (int x, int y) {
		return x >= 0 && y >= 0 && x < bounds.w && y < bounds.h;
	}
	
	/**
	* Adds a Tileset to this Map. If the set is already attached to this map,
	* addTileset simply returns.
	*
	* @param tileset a tileset to add
	*/
	public void add_tileset (TileSet tileset) {
		if (tileset == null || tile_sets.contains (tileset))
			return;

		unowned Tile t = tileset.tile (0);

		if (t != null) {
			int tw = t.width ();
			int th = t.height ();
			if (tw != tile_width)
				if (tile_width == 0) {
				    tile_width = tw;
				    tile_height = th;
				}
		}

		tile_sets.add (tileset);
	}
	
	/**
	* Removes a {@link TileSet} from the map, and removes any tiles in the set
	* from the map layers.
	*
	* @param tileset TileSet to remove
	*/
	public void remove_tileset (TileSet tileset) {
		// Sanity check
		final int tileset_index = tile_sets.index_of (tileset);
		if (tileset_index == -1)
			return;

		// Go through the map and remove any instances of the tiles in the set
		foreach (Tile tile in tileset.tiles) {
			foreach (MapLayer ml in layers) {
				if (ml is TileLayer) {
					((TileLayer) ml).remove_tile (tile);
				}
			}
		}

		tile_sets.remove_at (tileset_index);
	}
	
	/**
	* Returns wether the given tile coordinates fall within the map
	* boundaries.
	*
	* @param x The tile-space x-coordinate
	* @param y The tile-space y-coordinate
	* @return true if the point is within the map boundaries,
	*         false otherwise
	*/
	public boolean contains (int x, int y) {
		return x >= 0 && y >= 0 && x < bounds.w && y < bounds.h;
	}
	
	/**
	* Returns the maximum tile height. This is the height of the highest tile
	* in all tileSets or the tile height used by this map if it's smaller.
	*
	* @return int The maximum tile height
	*/
	public int tile_height_max () {
		int max_height = tile_height;

		foreach (TileSet tileset in tile_sets)
			if (tileset.tile_height > maxHeight)
				maxHeight = tileset.tile_height;

		return maxHeight;
	}
	
	/**
	* Swaps the tile sets at the given indices.
	*/
	public void swap_tile_sets (int index0, int index1) {
		if (index0 == index1)
			return;
		TileSet set = tile_sets.get (index0);
		tile_sets.set (index0, tile_sets.get (index1));
		tile_sets.set (index1, set);
	}
}// Map

/**
 * A layer of a map.
 *
 * @see Map
 */
public abstract class MapLayer {
	/** MIRROR_HORIZONTAL */
	public static final int MIRROR_HORIZONTAL = 1;
	/** MIRROR_VERTICAL */
	public static final int MIRROR_VERTICAL   = 2;

	/** ROTATE_90 */
	public static final int ROTATE_90  = 90;
	/** ROTATE_180 */
	public static final int ROTATE_180 = 180;
	/** ROTATE_270 */
	public static final int ROTATE_270 = 270;
	
	public string name;
	public bool is_visible;
	public unowned Map? my_map;
	public float opacity = 1.0f;
	public owned SDL.Rect bounds;
	
	public MapLayer () {
		bounds = {0};
		map = null;
	}
	
	/**
	* @param w width in tiles
	* @param h height in tiles
	*/
	public MapLayer.from_size (int w, int h) {
		bounds = {0, 0, w, h};
		map = null;
	}

	public MapLayer.from_rect (SDL.Rect r) {
		bounds = r;
		map = null;
	}
	
	/**
	* @param map the map this layer is part of
	*/
	public MapLayer.from_map (Map map) {
		bounds = {0};
		this.map = map;
	}
	
	/**
	* Performs a linear translation of this layer by (dx, dy).
	*
	* @param dx distance over x axis
	* @param dy distance over y axis
	*/
	public void translate (int dx, int dy) {
		bounds.x += dx;
		bounds.y += dy;
	}

	public abstract void rotate (int angle);

	public abstract void mirror (int dir);
	
	/**
	* Sets the offset of this map layer. The offset is a distance by which to
	* shift this layer from the origin of the map.
	*
	* @param x_off x offset in tiles
	* @param y_off y offset in tiles
	*/
	public void setOffset(int x_off, int y_off) {
		bounds.x = x_off;
		bounds.y = y_off;
	}

	/**
	* Assigns the layer bounds in tiles to the given rectangle.
	* @param rect the rectangle to which the layer bounds are assigned
	*/
	public void bounds (SDL.Rect rect) {
		rect.w = bounds.w;
		rect.h = bounds.h;
	}
	
	/**
	* Merges the tile data of this layer with the specified layer. The calling
	* layer is considered the significant layer, and will overwrite the data
	* of the argument layer. At cells where the calling layer has no data, the
	* argument layer data is preserved.
	*
	* @param other the insignificant layer to merge with
	*/
	public abstract void merge_onto (MapLayer other);

	public abstract void masked_merge_onto (MapLayer other, Area mask);

	public abstract void copy_from (MapLayer other);

	public abstract void masked_copy_from (MapLayer other, Area mask);

	public abstract MapLayer? create_diff (MapLayer? ml);
	
	/**
	* Unlike merge_onto, copy_to includes the null tile when merging
	*
	* @see MapLayer#copy_from
	* @see MapLayer#merge_onto
	* @param other the layer to copy this layer to
	*/
	public abstract void copy_to (MapLayer other);

	public abstract boolean is_empty ();
	
	/**
	* Creates a copy of this layer.
	*
	* @see Object#clone
	* @return a clone of this layer, as complete as possible
	* @exception CloneNotSupportedException
	*/
	public MapLayer clone () {
		MapLayer clone = new MapLayer.from_rect (bounds);
		// Needing to receive each paramaters cloning // TODO
		return clone;
	}

	/**
	* @param width  the new width of the layer
	* @param height the new height of the layer
	* @param dx     the shift in x direction
	* @param dy     the shift in y direction
	*/
	public abstract void resize (int width, int height, int dx, int dy);
}// MapLayer

/**
 * An object occupying an ObjectGroup.
 */
public class MapObject {
	public unowned ObjectGroup group;
	public SDL.Rect bouds = {0};
	private string name = "Object";
	private string type = "";
	
	// Considering change to a better "image" handler way // TODO
	public string image_source = "";
	private SDL.Texture image;
	
	public MapObject (int x, int y, int width, int height) {
		bounds = {x, y, width, height};
	}
	
	public MapObject.from_rect (SDL.Rect rect) {
		bounds = rect;
	}
	
	public MapObject clone () {
		MapObject clone = new MapObject.from_rect  (bounds);
		// Needing to receive each paramaters cloning // TODO
		return clone;
	}
	
	public void set_image (string source) {
		if (image_source == source)
			return;

		image_source = source;

		// Attempt to read the image
		image = SDLImage.load_texture (Aval.Game.WIN_RENDERER, image_source);
	}

	public void translate (int dx, int dy) {
		bounds.x += dx;
		bounds.y += dy;
	}
}// MapObject

/**
 * A layer containing {@link MapObject map objects}.
 */
public class ObjectGroup : MapLayer {
	private ArrayList<MapObject> objects = new ArrayList<MapObject> ();
	
	public ObjectGroup () { base (); }
	
	/**
	* Creates an object group that is part of the given map and has the given
	* origin.
	*
	* @param map    the map this object group is part of
	* @param origX  the x origin of this layer
	* @param origY  the y origin of this layer
	*/
	public ObjectGroup.from_orig (Map map, int orig_x, int orig_y) {
		base (map);
		this.bounds = {orig_x, orig_y, 0, 0};
	}

	/**
	* Creates an object group with a given area. The size of area is
	* irrelevant, just its origin.
	*
	* @param area the area of the object group
	*/
	public ObjectGroup.from_rect (SDL.Rect area) { base (area); 
	
	/**
	* @param map the map this layer is part of
	*/
	public ObjectGroup.from_map (Map map) {
		bounds = {0};
		this.map = map;
	}
	
	/**
	* @see MapLayer#rotate(int)
	*/
	public void rotate (int angle) {
		// TODO: Implement rotating an object group
	}
	
	/**
	* @see MapLayer#mirror(int)
	*/
	public void mirror (int dir) {
		// TODO: Implement mirroring an object group
	}

	public void merge_onto (MapLayer other) {
		// TODO: Implement merging with another object group
	}

	public void masked_merge_onto (MapLayer other, Area mask) {
		// TODO: Figure out what object group should do with this method
	}

	public void copy_from (MapLayer other) {
		// TODO: Implement copying from another object group (same as merging)
	}

	public void masked_copy_from (MapLayer other, Area mask) {
		// TODO: Figure out what object group should do with this method
	}

	public void copy_to (MapLayer other) {
		// TODO: Implement copying to another object group (same as merging)
	}
	
	/**
	* @see MapLayer#resize(int,int,int,int)
	*/
	public void resize(int width, int height, int dx, int dy) {
		// TODO: Translate contained objects by the change of origin
	}
	
	public boolean is_empty () {
		return objects.length < 1;
	}

	public void add_object (MapObject o) {
		objects.add (o);
		o.group = this;
	}

	public void remove_object (MapObject o) {
		objects.remove (o);
		o.group = null;
	}

	public MapObject? object_at (int x, int y) {
		foreach (MapObject obj in objects) {
			// Attempt to get an object bordering the point that has no width
			if (obj.bounds.w == 0 && obj.bounds.x + bounds.x == x) {
				return obj;
			}
			
			// Attempt to get an object bordering the point that has no height
			if (obj.bounds.h == 0 && obj.bounds.y + bounds.y == y) {
				return obj;
			}

			SDL.Rect rect = {obj.bounds.x + bounds.x * my_map.tile_width,
				obj.bounds.y + bounds.y * my_map.tile_height,
				obj.bounds.w, obj.bounds.h}
			if (rect.contains (x, y)) {
				return obj;
			}
		}
		return null;
	}
	
	public ObjectGroup clone () {
		ObjectGroup clone = new ObjectGroup.from_orig  (map, bounds.x, bounds.y);
		// Needing to receive each paramaters cloning // TODO
		foreach (MapObject object in objects)
			objects.add(object.clone ());
		return clone;
	}
}// ObjectGroup

/**
 * The core class for our tiles.
 */
public class Tile {
	private unowned TileSet tileset;
	// Tile rect inside tileset texture
	private SDL.Rect input_rect = {0};
	public int id = -1;
	
	public Tile.from_tileset (TileSet tileset) {
		this.tileset = tileset;
	}
}// Tile

/**
 * A TileLayer is a specialized MapLayer, used for tracking two dimensional
 * tile data.
 */
public class TileLayer : MapLayer {
	protected Tile?[][] map;
	
	public TileLayer {}
	public TileLayer.from_size (int w, int h) { base (w, h); }
	public TileLayer.from_rect (SDL.Rect r) { base (r); }
	public TileLayer.from_map (Map m) { base (m); }

	/**
	* @param m the map this layer is part of
	* @param w width in tiles
	* @param h height in tiles
	*/
	public TileLayer (Map m, int w, int h) {
		base (w, h);
		this.map = m;
	}
	
	/**
	* Rotates the layer by the given Euler angle.
	*
	* @param angle The Euler angle (0-360) to rotate the layer array data by.
	* @see MapLayer#rotate(int)
	*/
	public void rotate (int angle) {
		Tile[][] trans;
		int xtrans = 0, ytrans = 0;

		switch (angle) {
			case ROTATE_90:
				trans = new Tile[bounds.w][bounds.h];
				xtrans = bounds.h - 1;
				break;
			case ROTATE_180:
				trans = new Tile[bounds.h][bounds.w];
				xtrans = bounds.w - 1;
				ytrans = bounds.h - 1;
				break;
			case ROTATE_270:
				trans = new Tile[bounds.w][bounds.h];
				ytrans = bounds.w - 1;
				break;
			default:
				stderr.printf("Unsupported rotation (%d)\n", angle);
				return;
		}

		double ra = (double)angle * Math.PI / 180f;
		int cos_angle = (int)Math.round (Math.cos (ra));
		int sin_angle = (int)Math.round (Math.sin (ra));

		for (int y = 0; y < bounds.h; y++) {
			for (int x = 0; x < bounds.w; x++) {
				int xrot = x * cos_angle - y * sin_angle;
				int yrot = x * sin_angle + y * cos_angle;
				trans[yrot + ytrans][xrot + xtrans] = tile_at (x+bounds.x, y+bounds.y);
			}
		}

		bounds.w = trans[0].length;
		bounds.h = trans.length;
		map = trans;
	}

	/**
	* Performs a mirroring function on the layer data. Two orientations are
	* allowed: vertical and horizontal.
	*
	* Example: layer.mirror(MapLayer.MIRROR_VERTICAL); will
	* mirror the layer data around a horizontal axis.
	*
	* @param dir the axial orientation to mirror around
	*/
	public void mirror (int dir) {
		Tile[][] mirror = new Tile[bounds.h][bounds.w];
		for (int y = 0; y < bounds.h; y++) {
			for (int x = 0; x < bounds.w; x++) {
				if (dir == MIRROR_VERTICAL) {
					mirror[y][x] = map[bounds.h - 1 - y][x];
				} else {
					mirror[y][x] = map[y][bounds.w - 1 - x];
				}
			}
		}
		map = mirror;
	}
	
	/**
	* Checks to see if the given Tile is used anywhere in the layer.
	*
	* @param t a Tile object to check for
	* @return true if the Tile is used at least once,
	*         false otherwise.
	*/
	public boolean is_used (Tile t) {
		for (int y = 0; y < bounds.h; y++)
			for (int x = 0; x < bounds.w; x++)
				if (map[y][x] == t)
					return true;
		return false;
	}

	public boolean is_empty () {
		for (int p = 0; p < 2; p++)
			for (int y = 0; y < bounds.h; y++)
				for (int x = p; x < bounds.w; x += 2)
					if (map[y][x] != null)
						return false;
		return true;
	}
	
	/**
	* Sets the bounds (in tiles) to the specified Rectangle. <b>Caution:</b>
	* this causes a reallocation of the data array, and all previous data is
	* lost.
	*
	* @param bounds new new bounds of this tile layer (in tiles)
	* @see MapLayer#setBounds
	*/
	protected void set_bounds (SDL.Rect bounds) {
		this.bounds = bounds;
		map = new Tile[bounds.h][bounds.w];
	}
	
	/**
	* Creates a diff of the two layers, ml is considered the
	* significant difference.
	*
	* @param ml
	* @return A new MapLayer that represents the difference between this
	*         layer, and the argument, or null if no difference exists.
	*/
	public MapLayer? create_diff (MapLayer? ml) {
		if (ml == null) { return null; }

		if (ml is TileLayer) {
			SDL.Rect r = {0};

			for (int y = bounds.y; y < bounds.h + bounds.y; y++)
				for (int x = bounds.x; x < bounds.w + bounds.x; x++)
					if (((TileLayer)ml).tile_at (x, y) != tile_at (x, y)) {
						if (r != null) {
							r.x += x
							r.y += y;
						} else {
							r = {x, y, 0, 0};
						}
					}

			if (!r.equals ({0, 0, 0, 0})) {
				MapLayer diff = new TileLayer.from_rect ({r.x, r.y, r.w + 1, r.h + 1});
				diff.copy_from (ml);
				return diff;
			} else {
				return new TileLayer();
			}
		} else {
			return null;
		}
	}
	
	/**
	* Removes any occurences of the given tile from this map layer. If layer
	* is locked, an exception is thrown.
	*
	* @param tile the Tile to be removed
	*/
	public void remove_tile (Tile tile) {
		for (int y = 0; y < bounds.h; y++) {
			for (int x = 0; x < bounds.w; x++) {
				if (map[y][x] == tile) {
					set_tile_at (x + bounds.x, y + bounds.y, null);
				}
			}
		}
	}
	
	/**
	* Sets the tile at the specified position. Does nothing if (tx, ty) falls
	* outside of this layer.
	*
	* @param tx x position of tile
	* @param ty y position of tile
	* @param ti the tile object to place
	*/
	public void set_tile_at (int tx, int ty, Tile? ti) {
		if (bounds.contains(tx, ty)) {
		    map[ty - bounds.y][tx - bounds.x] = ti;
		}
	}
	
	/**
	* Returns the tile at the specified position.
	*
	* @param tx Tile-space x coordinate
	* @param ty Tile-space y coordinate
	* @return tile at position (tx, ty) or null when (tx, ty) is
	*         outside this layer
	*/
	public Tile? tile_at (int tx, int ty) {
		return (bounds.contains(tx, ty)) ?
			map[ty - bounds.y][tx - bounds.x] : null;
	}
	
	/**
	* Returns the first occurrence (using top down, left to right search) of
	* the given tile.
	*
	* @param t the Tile to look for
	* @return A java.awt.Point instance of the first instance of t, or
	*         null if it is not found
	*/
	public SDL.Point location_of (Tile t) {
		for (int y = bounds.y; y < bounds.h + bounds.y; y++)
			for (int x = bounds.x; x < bounds.w + bounds.x; x++)
				if (tile_at (x, y) == t)
					return {x, y};
		return null;
	}

	/**
	* Replaces all occurrences of the Tile find with the Tile
	* replace in the entire layer
	*
	* @param find    the tile to replace
	* @param replace the replacement tile
	*/
	public void replace_tile (Tile find, Tile replace) {
		for (int y = bounds.y; y < bounds.y + bounds.h; y++)
			for (int x = bounds.x; x < bounds.x + bounds.w; x++)
				if(tile_at (x, y) == find)
				    set_tile_at (x, y, replace);
	}
	
	/**
	* @inheritDoc MapLayer#merge_onto(MapLayer)
	*/
	public void merge_onto (MapLayer other) {
		for (int y = bounds.y; y < bounds.y + bounds.h; y++)
			for (int x = bounds.x; x < bounds.x + bounds.w; x++) {
				Tile tile = tile_at (x, y);
				if (tile != null)
					((TileLayer) other).set_tile_at (x, y, tile);
			}
	}
	
	/**
	* Like merge_onto, but will only copy the area specified.
	*
	* @see TileLayer#merge_onto(MapLayer)
	* @param other
	* @param mask
	*/
	public void masked_merge_onto (MapLayer other, Area mask) {
		unowned SDL.Rect bound_box = mask.bounds;

		for (int y = bound_box.y; y < bound_box.y + bound_box.h; y++)
			for (int x = bound_box.x; x < bound_box.x + bound_box.w; x++) {
				Tile tile = ((TileLayer) other).tile_at (x, y);
				if (mask.contains (x, y) && tile != null)
					set_tile_at (x, y, tile);
			}
	}
	
	/**
	* Copy data from another layer onto this layer. Unlike merge_onto,
	* copy_from copies the empty cells as well.
	*
	* @see MapLayer#merge_onto
	* @param other
	*/
	public void copy_from (MapLayer other) {
		for (int y = bounds.y; y < bounds.y + bounds.h; y++)
			for (int x = bounds.x; x < bounds.x + bounds.w; x++)
				set_tile_at (x, y, ((TileLayer) other).tile_at (x, y));
	}
	
	/**
	* Like copy_from, but will only copy the area specified.
	*
	* @see TileLayer#copy_from(MapLayer)
	* @param other
	* @param mask
	*/
	public void masked_copy_from (MapLayer other, Area mask) {
		unowned SDL.Rect bound_box = mask.bounds;

		for (int y = bound_box.y; y < bound_box.y + bound_box.h; y++)
			for (int x = bound_box.x; x < bound_box.x + bound_box.w; x++)
				if (mask.contains (x,y))
					set_tile_at (x, y, ((TileLayer) other).tile_at (x, y));
	}
	
	/**
	* Unlike merge_onto, copy_from includes the null tile when merging.
	*
	* @see MapLayer#copy_from
	* @see MapLayer#merge_onto
	* @param other the layer to copy this layer to
	*/
	public void copy_to (MapLayer other) {
		for (int y = bounds.y; y < bounds.y + bounds.h; y++)
			for (int x = bounds.x; x < bounds.x + bounds.w; x++)
				((TileLayer) other).set_tile_at (x, y, tile_at (x, y));
	}
	
	/**
	* Creates a copy of this layer.
	*
	* @see Object#clone
	* @return a clone of this layer, as complete as possible
	* @exception CloneNotSupportedException
	*/
	public TileLayer clone () {
		TileLayer clone = new TileLayer.from_rect (bounds);
		// Needing to receive each paramaters cloning // TODO
		
		// Clone the layer data
		clone.map = new Tile[map.layers.length][];
		
		for (int i = 0; i < map.layers.length; i++) {
			clone.map.layers[i].tiles = new Tile[map.layers[i].tiles.length];
			//System.arraycopy (map[i], 0, clone.map[i], 0, map[i].length);
			// Find a non Posix specific function // TODO
			Posix.memcpy (map.layers[i].tiles, clone.map.layers[i].tiles, map.layers[i].length * sizeof (Tile));
		}

		return clone;
	}
	
	/**
	* @param width  the new width of the layer
	* @param height the new height of the layer
	* @param dx     the shift in x direction
	* @param dy     the shift in y direction
	*/
	public void resize (int width, int height, int dx, int dy) {
		Tile[][] new_map = new Tile[height][width];

		int max_x = Math.min (width, bounds.w + dx);
		int max_y = Math.min (height, bounds.h + dy);

		for (int x = Math.max (0, dx); x < max_x; x++)
			for (int y = Math.max (0, dy); y < max_y; y++)	
				new_map[y][x] = tile_at (x - dx, y - dy);

		map = new_map;
		bounds.w = width;
		bounds.h = height;
	}
}// TileLayer

/**
 * todo: Update documentation
 * <p>TileSet handles operations on tiles as a set, or group. It has several
 * advanced internal functions aimed at reducing unnecessary data replication.
 * A 'tile' is represented internally as two distinct pieces of data. The
 * first and most important is a {@link Tile} object, and these are held in
 * a {@link Vector}.</p>
 *
 * <p>The other is the tile image.</p>
 */
public class TileSet {
	private string _base;
	final private Array<Tile> tiles = new Aray<Tile>;
	
	protected TileCutter tile_cutter;
	protected SDL.Rect tile_dimensions;
	private int tile_spacing;
	private int tile_marging;
	private int tiles_per_row;
	protected SDL.Texture? image;
	public string name;
	
	/**
	* Default constructor
	*/
	public TileSet () {
		tile_dimensions = {0};
	}
	
	/**
	* Creates a tileset from a tileset image file.
	*
	* @param filename
	* @param cutter
	*/
	public void import_tile_bitmap (string filename, TileCutter cutter, SDL.Color? transparent_color=null) {
		setTilesetImageFilename(imgFilename);

		SDL.Surface s_image = SDLImage.load_texture (Aval.Game.WIN_RENDERER, image_source);
		if (s_image == null)
			image = null;
			return;
		}

		if (transparent_color != null) {
			SDL_SetColorKey(bmp_surface, true, transparent_color);
		}

		image = newTexture.from_surface(Aval.Game.WIN_RENDERER, s_image);

		cutter.image = image;
		cutter.image_w = s_image.w;
		cutter.image_h = s_image.h;
	}
	
}
// TODO: AnimatedTileset, IO, Area and Renderer

}// Tiled