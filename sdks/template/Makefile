VALAC = valac
VFLAG += -X -O4 -X '-lSDL2' -X '-lSDL2_image' -X '-lSDL2_mixer' -X '-lSDL2_ttf' -X '-lSDL2_gfx' -X '-lchipmunk'
VPKGS += --pkg sdl2 --pkg sdl2-image --pkg sdl2-mixer --pkg sdl2-ttf --pkg sdl2-gfx --pkg posix --pkg chipmunk
VBASE += $(wildcard $(AVALANCHE_DIR)/sdks/avalanche/*.vala)
SRC = ./$(wildcard src/*.vala)
BIN   = ./bin/game

ifeq ($(CROSS), WIN32)
	PKG_CONFIG_PATH=/usr/i486-mingw32/lib/pkgconfig
	VFLAG += --cc=i486-mingw32-gcc
	OS = Windows_NT
else ifeq ($(CROSS), ANDROID)
	#SOON
	
	JNI = 1
	OS = Android
endif


ifeq ($(DEBUG), 1)
	VFLAG += --enable-gobject-tracing --enable-checking -g
endif


ifeq ($(JNI), 1)
	VBASE += $(AVALANCHE_DIR)/sdks/avalanche/avalanche_jni.h
	VFLAG+= -D AVALANCHE_JNI
	SHARED = 1
endif


ifeq ($(OS), Windows_NT)
	BIN =  ./bin/game.exe
	CLEAN := rm -f $(BIN)
	VFLAG += -X -mwindows -D AVALANCE_WIN
else ifeq ($(OS), Android)
	VFLAG+= -D AVALANCE_UNIX -D AVALANCHE_LINUX -D AVALANCHE_ANDROID
else
	UNAME := $(shell uname)
	ifeq ($(UNAME), Linux)
		BIN =  ./bin/game.elf
		VFLAG+= -D AVALANCE_UNIX -D AVALANCHE_LINUX
	else ifeq ($(UNAME), Darwin)
		VFLAG+= -D AVALANCE_UNIX -D AVALANCHE_DARWIN
	endif
endif


ifeq ($(SHARED), 1)
	VFLAG+= -X -shared
	ifeq ($(OS), Windows_NT)
		BIN =  ./bin/game.dll
	else
		BIN =  ./bin/libgame.so
	endif
endif


.PHONY:
	 rmdir "./bin"
	$(CLEAN)

build:
	@mkdir "./bin" 2>/dev/null; true;
	$(VALAC) $(SRC) $(VBASE) $(VPKGS) $(VFLAG) -o $(BIN)

clean: .PHONY
default: build
