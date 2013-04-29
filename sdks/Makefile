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
VFLAG = -X -Ofast -X '-lSDL2' --vapidir=./vala/thirds
VPKGS = --pkg sdl2
VBASE   = ./$(wildcard vala/avalanche/*.vala)
SRC   = ./$(wildcard vala/$(GAME)/src/*.vala)
BIN   = ./../bin/game-$(GAME)

ifeq ($(OS), Windows_NT)
	CLEAN := rm -f $(BIN)
	VFLAG += -X -mwindows
else
	UNAME := $(shell uname)
	ifeq ($(UNAME), Linux)
	endif
	ifeq ($(UNAME), Darwin)
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
