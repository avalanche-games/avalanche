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
VFLAG = -X -Ofast -X '-lSDL2' -X '-lSDL2_image' --vapidir=./thirds
VPKGS = --pkg sdl2 --pkg sdl2-image --pkg posix
VBASE = ./$(wildcard avalanche/*.vala)
SRC = $(wildcard $(GAMEDIR)/src/*.vala)
BIN   = $(GAMEDIR)/bin/game

ifeq ($(CROSS), WIN)
	PKG_CONFIG_PATH=/usr/i486-mingw32/lib/pkgconfig
	VFLAG += --cc=i486-mingw32-gcc
	OS = Windows_NT
endif


ifeq ($(OS), Windows_NT)
	BIN =  $(GAMEDIR)/bin/game.exe
	CLEAN := rm -f $(BIN)
	VFLAG += -X -mwindows -D AVALANCE_WIN
else
	UNAME := $(shell uname)
	ifeq ($(UNAME), Linux)
		BIN =  $(GAMEDIR)/bin/game.elf
		VFLAG+= -D AVALANCE_UNIX -D AVALANCHE_LINUX
	endif
	ifeq ($(UNAME), Darwin)
		VFLAG+= -D AVALANCE_UNIX -D AVALANCHE_DARWIN
	endif
endif


.PHONY:
	 rmdir "$(GAMEDIR)/bin"
	$(CLEAN)

build:
	@mkdir "$(GAMEDIR)/bin" 2>/dev/null; true;
	$(VALAC) $(VPKGS) $(VFLAG) $(VBASE) $(SRC) -o $(BIN)

clean: .PHONY
default: build
