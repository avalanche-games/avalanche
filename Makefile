##
#  This Source Code Form is subject to the terms of the Mozilla Public
#  License, v. 2.0. If a copy of the MPL was not distributed with this
#  file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
#                          Copyright(C) 2013
#                   Christian Ferraz Lemos de Sousa
#                      Pedro Henrique Lara Campos
##

VALAC = valac
P_BIN = ./bin/Game
P_SRC = ./$(wildcard src/player/*.vala)
P_PKG = --pkg sdl --pkg sdl-gfx
P_OPT = -X -lSDL_gfx
E_BIN = ./bin/avalanche
E_SRC = ./$(wildcard src/editor/*.vala)
E_PKG = --pkg gio-2.0 --pkg json-glib-1.0 --pkg gtk+-3.0 --pkg gtksourceview-3.0 --pkg gee-0.8 -X -lm
E_OPT = 

install:
	@echo "Preparing to install..."
	@mkdir "/usr/" 2>/dev/null; true
	@mkdir "/usr/bin/" 2>/dev/null; true
	@mkdir "/usr/lib/" 2>/dev/null; true
	@mkdir "/usr/local/" 2>/dev/null; true
	@mkdir "/usr/local/share/" 2>/dev/null; true
	@mkdir "/usr/local/share/applications/" 2>/dev/null; true
	@echo -e "\nCreating directories..."
	@echo -e "mkdir \"/usr/lib/avalanche/\""
	@mkdir "/usr/lib/avalanche/"; true
	@echo -e "mkdir \"/usr/lib/avalanche/icons/\""
	@mkdir "/usr/lib/avalanche/syntax-colors/"; true
	@echo -e "mkdir \"/usr/lib/avalanche/icons/\""
	@mkdir "/usr/lib/avalanche/icons/"; true
	@echo -e "\nInstalling files..."
	cp -f "./bin/avalanche" "/usr/bin/avalanche"
	cp -f "./res/syntax-colors/tonight.xml" "/usr/lib/avalanche/syntax-colors/tonight.xml"
	cp -f "./res/icons/avalanche.png" "/usr/lib/avalanche/icons/avalanche.png"
	cp -f "./res/shortcuts/avalanche.desktop" "/usr/local/share/applications/avalanche.desktop"

uninstall:
	rm -f "/usr/bin/avalanche"
	rm -f "/usr/lib/avalanche/syntax-colors/tonight.xml"
	rm -f "/usr/lib/avalanche/icons/avalanche.png"
	rm -f "/usr/local/share/applications/avalanche.desktop"
	rmdir "/usr/lib/avalanche/syntax-colors/"
	rmdir "/usr/lib/avalanche/icons/"
	rmdir "/usr/lib/avalanche/"

editor:
	$(VALAC) $(E_PKG) $(E_OPT) $(E_SRC) -o $(E_BIN)
player:
	$(VALAC) $(P_PKG) $(P_OPT) $(P_SRC) -o $(P_BIN)
arch:
	@echo "to build/run you must install \`vala, glib, libgee, gtk3, gtksourceview3, json-glib\`:"
	@echo "  pacman -S glib vala libgee gtk3 gtksourceview3 json-glib"
.PHONY:
	rm -f $(E_BIN) $(P_BIN)
clean: .PHONY
all: editor player
default: all
