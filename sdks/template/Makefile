VALAC = valac
VFLAG += -X -O4 -X '-lSDL2' -X '-lSDL2_image' -X '-lSDL2_mixer' -X '-lSDL2_ttf' -X '-lSDL2_gfx' -X '-lchipmunk'
VPKGS += --pkg sdl2 --pkg sdl2-image --pkg sdl2-mixer --pkg sdl2-ttf --pkg sdl2-gfx --pkg posix --pkg chipmunk
VBASE += $(wildcard $(AVALANCHE_DIR)/sdks/avalanche/*.vala)
SRC = ./$(wildcard src/*.vala)
BIN   = ./bin/game

ifeq ($(CROSS), WIN)
	PKG_CONFIG_PATH=/usr/i486-mingw32/lib/pkgconfig
	VFLAG += --cc=i486-mingw32-gcc
	OS = Windows_NT
else ifeq ($(CROSS), ANDROID)
	PKG_CONFIG_PATH=/opt/android-ndk/platforms/android-9/arch-arm/usr/lib/pkgconfig
	VFLAG := --cc=/opt/android-ndk/toolchains/arm-linux-androideabi-4.8/prebuilt/linux-x86/bin/arm-linux-androideabi-gcc \
		-X --sysroot=/opt/android-ndk/platforms/android-9/arch-arm/ \
		-X -march=armv5 -X -Wl,--fix-cortex-a8 \
		-X -static $(VFLAG) -X --shared
	VFLAG += -X -L/opt/android-ndk/platforms/android-9/arch-arm/usr/lib/
	VFLAG += -X -I/opt/android-ndk/platforms/android-9/arch-arm/usr/include/
	OS = Android
endif


ifeq ($(OS), Windows_NT)
	BIN =  ./bin/game.exe
	CLEAN := rm -f $(BIN)
	VFLAG += -X -mwindows -D AVALANCE_WIN
else ifeq ($(OS), Android)
	VBASE += $(AVALANCHE_DIR)/sdks/avalanche/avalanche_jni.h
	BIN =  ./bin/libandroid_game.so
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


.PHONY:
	 rmdir "./bin"
	$(CLEAN)

build:
	@mkdir "./bin" 2>/dev/null; true;
	$(VALAC) $(SRC) $(VBASE) $(VPKGS) $(VFLAG) -o $(BIN)

clean: .PHONY
default: build
