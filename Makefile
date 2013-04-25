# Copyright (C) 2013 - Avalanche Project
VALAC = valac
P_BIN = ./bin/Game
P_SRC = ./$(wildcard src/player/*.vala)
P_PKG = --pkg sdl --pkg sdl-gfx
P_OPT = -X -lSDL_gfx
E_BIN = ./bin/Avalanche
E_SRC = ./$(wildcard src/editor/*.vala)
E_PKG = --pkg gtksourceview-3.0 --pkg gtk+-3.0
E_OPT = 

editor:
	$(VALAC) $(E_PKG) $(E_OPT) $(E_SRC) -o $(E_BIN)
player:
	$(VALAC) $(P_PKG) $(P_OPT) $(P_SRC) -o $(P_BIN)
.PHONY:
	rm -f $(E_BIN) $(P_BIN)
clean: .PHONY
all: editor player
default: all
