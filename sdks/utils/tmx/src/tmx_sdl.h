#pragma once

#ifndef SDL_TMX_COMPL_H
#define SDL_TMX_COMPL_H

#include <stdio.h>
#include <tmx.h>
#include <SDL2/SDL.h>
#include <SDL2/SDL_events.h>
#include <SDL2/SDL_keyboard.h>
#include <SDL2/SDL_keycode.h>
#include <SDL2/SDL_image.h>

#ifdef __cplusplus
extern "C" {
#endif

void set_color(SDL_Renderer* ren, int color);
void draw_polyline(SDL_Renderer* ren, int **points, int x, int y, int pointsc);
void draw_polygon(SDL_Renderer* ren, int **points, int x, int y, int pointsc);
void draw_objects(SDL_Renderer* ren, tmx_object *head, int color);
int gid_clear_flags(unsigned int gid);
short get_bitmap_region(unsigned int gid, tmx_tileset *ts, SDL_Surface **ts_bmp, unsigned int *x, unsigned int *y, unsigned int *w, unsigned int *h);
void draw_layer(SDL_Renderer* ren, tmx_layer *layer, tmx_tileset *ts, unsigned int width, unsigned int height, unsigned int tile_width, unsigned int tile_height);
void draw_image_layer(SDL_Renderer* ren, tmx_image *img);
SDL_Texture* render_map(SDL_Renderer* ren, tmx_map *map);
void tmxsdl_init();

#ifdef __cplusplus
}
#endif

#endif /* SDL_TMX_COMPL_H */