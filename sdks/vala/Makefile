##
#                          Copyright(C) 2013
#                   Christian Ferraz Lemos de Sousa
#                      Pedro Henrique Lara Campos
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
##

VALAC = valac
VFLAG = -X -Ofast -X '-lSDL2' --vapidir=./vala/thirds
VPKGS = --pkg sdl2
VBASE   = ./$(wildcard avalanche/*.vala)
SRC   = ./$(wildcard $(GAME)/src/*.vala)
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
	$(CLEAN)
	@rmdir "../bin" 2>/dev/null; true;

build:
	@mkdir "../bin" 2>/dev/null; true;
	$(VALAC) $(VPKGS) $(VFLAG) $(VBASE) $(SRC) -o $(BIN)

clean: .PHONY
default: build
