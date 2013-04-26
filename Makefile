# Copyright (C) 2013 - Avalanche Project
VALAC = valac
P_BIN = ./bin/Game
P_SRC = ./$(wildcard src/player/*.vala)
P_PKG = --pkg sdl --pkg sdl-gfx
P_OPT = -X -lSDL_gfx
E_BIN = ./bin/avalanche
E_SRC = ./$(wildcard src/editor/*.vala)
E_PKG = --pkg gio-2.0 --pkg json-glib-1.0 --pkg gtk+-3.0 --pkg gtksourceview-3.0 --pkg gee-1.0 -X -lm
E_OPT = 

editor:
	$(VALAC) $(E_PKG) $(E_OPT) $(E_SRC) -o $(E_BIN)
player:
	$(VALAC) $(P_PKG) $(P_OPT) $(P_SRC) -o $(P_BIN)
arch:
	@echo "to build/run you must install \`glib, libgee, gtk3, gtksourceview3, json-glib\`:"
	@echo "  pacman -S glib libgee gtk3 gtksourceview3 json-glib"
.PHONY:
	rm -f $(E_BIN) $(P_BIN)
clean: .PHONY
all: editor player
default: all
