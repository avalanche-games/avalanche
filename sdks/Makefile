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
VFLAG = -X -Ofast -X '-lSDL2' -X '-lSDL2_image' -X '-lchipmunk' --vapidir=./vala/thirds
VPKGS = --pkg sdl2 --pkg sdl2-image --pkg chipmunk --pkg posix
VBASE   = ./$(wildcard vala/avalanche/*.vala)
SRC   = ./$(wildcard vala/$(GAME)/src/*.vala)
BIN   = ./../bin/game-$(GAME)

ifeq ($(OS), Windows_NT)
	CLEAN := rm -f $(BIN)
	VFLAG += -X -mwindows -D AVALANCE_WIN
else
	UNAME := $(shell uname)
	ifeq ($(UNAME), Linux)
		VFLAG+= -D AVALANCE_UNIX -D AVALANCHE_LINUX
	endif
	ifeq ($(UNAME), Darwin)
		VFLAG+= -D AVALANCE_UNIX -D AVALANCHE_DARWIN
	endif
endif


.PHONY:
	 rmdir "../../bin"
	$(CLEAN)

build:
	@mkdir "../../bin" 2>/dev/null; true;
	$(VALAC) $(VPKGS) $(VFLAG) $(VBASE) $(SRC) -o $(BIN)

clean: .PHONY
default: build
