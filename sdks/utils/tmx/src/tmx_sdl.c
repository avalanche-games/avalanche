/*
	Taken from TMX usage example with SDL 2
	requires SDL_image

Copyright (c) 2013, Bayle Jonathan <baylej@github>
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

 * Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.

 * Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND ANY
EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE REGENTS AND CONTRIBUTORS BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

#include <stdio.h>
#include <tmx.h>
#include <SDL2/SDL.h>
#include <SDL2/SDL_events.h>
#include <SDL2/SDL_keyboard.h>
#include <SDL2/SDL_keycode.h>
#include <SDL2/SDL_image.h>
#include <string.h>
#include "tmx_sdl.h"

void set_color(SDL_Renderer* ren, int color) {
	unsigned char r, g, b;

	r = (color >> 16) & 0xFF;
	g = (color >>  8) & 0xFF;
	b = (color)       & 0xFF;

	SDL_SetRenderDrawColor(ren, r, g, b, SDL_ALPHA_OPAQUE);
}

void draw_polyline(SDL_Renderer* ren, int **points, int x, int y, int pointsc) {
	int i;
	for (i=1; i<pointsc; i++) {
		SDL_RenderDrawLine(ren, x+points[i-1][0], y+points[i-1][1], x+points[i][0], y+points[i][1]);
	}
}

void draw_polygon(SDL_Renderer* ren, int **points, int x, int y, int pointsc) {
	draw_polyline(ren, points, x, y, pointsc);
	if (pointsc > 2) {
		SDL_RenderDrawLine(ren, x+points[0][0], y+points[0][1], x+points[pointsc-1][0], y+points[pointsc-1][1]);
	}
}

void draw_objects(SDL_Renderer* ren, tmx_object *head, int color) {
	SDL_Rect rect;
	set_color(ren, color);
	/* FIXME line thickness */
	while (head) {
		if (head->visible) {
			if (head->shape == S_SQUARE) {
				rect.x =     head->x;  rect.y =      head->y;
				rect.w = head->width;  rect.h = head->height;
				SDL_RenderDrawRect(ren, &rect);
			} else if (head->shape  == S_POLYGON) {
				draw_polygon(ren, head->points, head->x, head->y, head->points_len);
			} else if (head->shape == S_POLYLINE) {
				draw_polyline(ren, head->points, head->x, head->y, head->points_len);
			} else if (head->shape == S_ELLIPSE) {
				/* FIXME: no function in SDL2 */
			}
		}
		head = head->next;
	}
}

int gid_clear_flags(unsigned int gid) {
	return gid & TMX_FLIP_BITS_REMOVAL;
}

/* returns the bitmap and the region associated with this gid, returns -1 if tile not found */
short get_bitmap_region(unsigned int gid, tmx_tileset *ts, SDL_Surface **ts_bmp, unsigned int *x, unsigned int *y, unsigned int *w, unsigned int *h) {
	unsigned int tiles_x_count;
	unsigned int ts_w, id, tx, ty;
	gid = gid_clear_flags(gid);
	
	while (ts) {
		if (ts->firstgid <= gid) {
			if (!ts->next || ts->next->firstgid < ts->firstgid || ts->next->firstgid > gid) {
				id = gid - ts->firstgid; /* local id (for this image) */
				
				ts_w = ts->image->width  - 2 * (ts->margin) + ts->spacing;
				
				tiles_x_count = ts_w / (ts->tile_width  + ts->spacing);
				
				*ts_bmp = (SDL_Surface*)ts->image->resource_image;
				
				*w = ts->tile_width;  /* set bitmap's region width  */
				*h = ts->tile_height; /* set bitmap's region height */
				
				tx = id % tiles_x_count;
				ty = id / tiles_x_count;
				
				*x = ts->margin + (tx * ts->tile_width)  + (tx * ts->spacing); /* set bitmap's region */
				*y = ts->margin + (ty * ts->tile_height) + (ty * ts->spacing); /* x and y coordinates */
				return 0;
			}
		}
		ts = ts->next;
	}
	
	return -1;
}

void draw_layer(SDL_Renderer* ren, tmx_layer *layer, tmx_tileset *ts, unsigned int width, unsigned int height, unsigned int tile_width, unsigned int tile_height) {
	unsigned long i, j;
	unsigned int x, y, w, h;
	float op;
	SDL_Surface *tileset;
	SDL_Texture *tex_ts;
	SDL_Rect srcrect, dstrect;
	op = layer->opacity;
	for (i=0; i<height; i++) {
		for (j=0; j<width; j++) {
			if (!get_bitmap_region(layer->content.gids[(i*width)+j], ts, &tileset, &x, &y, &w, &h)) {
				/* TODO Opacity and Flips */
				srcrect.w = w;  srcrect.h = h;  srcrect.x = x;             srcrect.y = y;
				dstrect.w = w;  dstrect.h = h;  dstrect.x = j*tile_width;  dstrect.y = i*tile_height;
				tex_ts = SDL_CreateTextureFromSurface(ren, tileset);
				SDL_RenderCopy(ren, tex_ts, &srcrect, &dstrect);
				SDL_DestroyTexture(tex_ts);
			}
		}
	}
}

void draw_image_layer(SDL_Renderer* ren, tmx_image *img) {
	SDL_Surface *bmp; 
	SDL_Texture *tex;
	SDL_Rect dim;
	
	bmp =  (SDL_Surface*)img->resource_image;
	
	dim.x = dim.y = 0;
	dim.w = bmp->w;
	dim.h = bmp->h;
	
	if ((tex = SDL_CreateTextureFromSurface(ren, bmp))) {
		SDL_RenderCopy(ren, tex, NULL, &dim);
		SDL_DestroyTexture(tex);
	}
	
}

/* Needs a remake, I'm considering creating
a new function that returns an array with one
texture for each layer and that renders only a
specific rect of the level. */
SDL_Texture* render_map(SDL_Renderer* ren, tmx_map *map) {
	SDL_Texture *res;
	tmx_layer *layers = map->ly_head;
	int w, h;
	
	w = map->width  * map->tile_width;  /* Bitmap's width and height */
	h = map->height * map->tile_height;
	
	if (!(res = SDL_CreateTexture(ren, SDL_PIXELFORMAT_RGBA8888, SDL_TEXTUREACCESS_TARGET, w, h)))
		return 0;
	SDL_SetRenderTarget(ren, res);
	
	set_color(ren, map->backgroundcolor);
	SDL_RenderClear(ren);
	
	while (layers) {
		if (layers->visible && strcmp(layers->name, "physics") != 0) {
			if (layers->type == L_OBJGR) {
				draw_objects(ren, layers->content.head, layers->color);
			} else if (layers->type == L_IMAGE) {
				draw_image_layer(ren, layers->content.image);
			} else if (layers->type == L_LAYER) {
				draw_layer(ren, layers, map->ts_head, map->width, map->height, map->tile_width, map->tile_height);
			}
		}
		layers = layers->next;
	}
	
	SDL_SetRenderTarget(ren, NULL);
	return res;
}

/* Yeah you got me, if I knew how to do this in Vala,
It would be already done. */
void tmxsdl_init() {
	tmx_img_load_func = (void* (*)(const char*))IMG_Load;
	tmx_img_free_func = (void  (*)(void*))SDL_FreeSurface;
}