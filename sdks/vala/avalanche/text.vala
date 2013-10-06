/*
 *  This Source Code Form is subject to the terms of the Mozilla Public
 *  License, v. 2.0. If a copy of the MPL was not distributed with this
 *  file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 *                          Copyright(C) 2013
 *                   Christian Ferraz Lemos de Sousa
 *                      Pedro Henrique Lara Campos
 *
 */

namespace Aval {

public class Text {
	private weak SDLTTF.Font font;
	private SDL.Color stdcolor;
	
	private SDL.Texture? texture;
	private SDL.Point pos;
	private SDL.Rect input;
	private SDL.Rect output;
	
	public Text (SDLTTF.Font _font, SDL.Color _stdcolor, SDL.Point start_pos){
		this.font = _font;
		this.stdcolor = _stdcolor;
		this.pos = start_pos;
	}
	
	public void set_pos (SDL.Point new_pos) {
		this.pos = new_pos;
		output = {pos.x, pos.y, output.w, output.h};
	}
	
	public void set_color (SDL.Color new_color) {
		this.stdcolor = new_color;
	}
	
	public bool set_text (string text) {
		SDL.Surface? surface = font.render_utf8 (text, stdcolor);
			if (surface == null) return failed ();
		input = {0, 0, surface.w, surface.h};
		output = {pos.x, pos.y, surface.w, surface.h};
		texture = new SDL.Texture.from_surface (Aval.Game.WIN_RENDERER, surface);
			if (texture == null) return failed ();
		return true;
	}
	
	private bool failed () {
		texture = null;
		return false;
	}
	
	public void draw () {
		if (texture != null)
			Aval.Game.WIN_RENDERER.copy (texture, input, output);
	}
}// Text


}// Aval