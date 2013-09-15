VALAC = valac
VFLAG = -X -Ofast -X '-lSDL2' -X '-lSDL2_image' -X '-lchipmunk'
VPKGS = --pkg sdl2 --pkg sdl2-image --pkg posix --pkg chipmunk
VBASE = $(wildcard $(AVALANCHE_DIR)/sdks/vala/avalanche/*.vala)
SRC = ./$(wildcard src/*.vala)
BIN   = ./bin/game

ifeq ($(CROSS), WIN)
	PKG_CONFIG_PATH=/usr/i486-mingw32/lib/pkgconfig
	VFLAG += --cc=i486-mingw32-gcc
	OS = Windows_NT
endif


ifeq ($(OS), Windows_NT)
	BIN =  ./bin/game.exe
	CLEAN := rm -f $(BIN)
	VFLAG += -X -mwindows -D AVALANCE_WIN
else
	UNAME := $(shell uname)
	ifeq ($(UNAME), Linux)
		BIN =  ./bin/game.elf
		VFLAG+= -D AVALANCE_UNIX -D AVALANCHE_LINUX
	endif
	ifeq ($(UNAME), Darwin)
		VFLAG+= -D AVALANCE_UNIX -D AVALANCHE_DARWIN
	endif
endif


.PHONY:
	 rmdir "./bin"
	$(CLEAN)

build:
	@mkdir "./bin" 2>/dev/null; true;
	$(VALAC) $(VPKGS) $(VFLAG) $(VBASE) $(SRC) -o $(BIN)

clean: .PHONY
default: build
