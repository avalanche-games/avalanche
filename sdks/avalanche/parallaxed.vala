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

public class Parallaxed {
	SDL.Texture texture;
	public int texture_width;
	public int texture_height;
	public int force_height;
	int base_y;
	int *xpositions;
	int speed;
	int num;
	
	public Parallaxed (string texture_path, int screen_width, int speed, int base_y=0, int force_height=0) {
		this.base_y = base_y;
		this.texture_width = 0;
		this.speed = speed;
		this.force_height = force_height;
		this.texture = SDLImage.load_texture (Aval.Game.WIN_RENDERER, texture_path);
		texture.query (null, null, out texture_width, out texture_height);
		
		num = (screen_width / texture_width + 1);
		xpositions = new int[num];
		for (int i=0; i < num; i++)
			xpositions[i] = (i * texture_width);
	}
	
	public void update () {
		for (int i=0; i < num; i++) {
			xpositions[i] += speed;
			if (speed <= 0)
				if (xpositions[i] <= -texture_width)
					xpositions[i] = texture_width * (num - 1);
			else {
				if (xpositions[i] >= texture_width * (num - 1))
					xpositions[i] = -texture_width;
			}
		}
	}
	
	public void draw () {
		for (int i=0; i < num; i++)
			Aval.Game.WIN_RENDERER.copy (texture, {0, 0, texture_width, texture_height},
				{xpositions[i], base_y, texture_width, (force_height == 0 ? texture_height : force_height)});
	}
}// Parallaxed


}// Aval