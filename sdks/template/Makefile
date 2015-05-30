VALAC = valac
VFLAG += -X -O4 -X '-lSDL2_image' -X '-lSDL2_mixer' -X '-lSDL2_ttf' -X '-lSDL2_gfx' -X '-lSDL2' -X '-lchipmunk'
VPKGS += --pkg sdl2 --pkg sdl2-image --pkg sdl2-mixer --pkg sdl2-ttf --pkg sdl2-gfx --pkg posix --pkg chipmunk --pkg gee-0.8
VBASE += $(wildcard $(AVALANCHE_DIR)/sdks/avalanche/*.vala)
SRC = $(wildcard src/*.vala)
BIN   = ./bin/game
STRIP ?= strip

ifeq ($(CROSS), MINGW)
	MINGW_PREFIX ?= i686-w64
	
	PKG_CONFIG_PATH=/usr/$(MINGW_PREFIX)-mingw32/lib/pkgconfig
	VFLAG += --cc=$(MINGW_PREFIX)-mingw32-gcc --pkg sdl2-windows
	OS = Windows_NT
else ifeq ($(CROSS), ANDROID)
	ANDROID_TOOLCHAIN ?= /opt/android-toolchain
	ANDROID_PREFIX ?= arm-linux-androideabi
	
	PKG_CONFIG_PATH = "$(ANDROID_TOOLCHAIN)/sysroot/usr/lib/pkgconfig"
	LDFLAGS = '-Wl,--fix-cortex-a8' 
	CFLAGS = '-march=armv5 -mfloat-abi=softfp -mfpu=neon' 
	
	VFLAG := --cc=$(ANDROID_TOOLCHAIN)/bin/$(ANDROID_PREFIX)-gcc \
		-X -L"$(ANDROID_TOOLCHAIN)/$(ANDROID_PREFIX)/lib" \
		-X -L"$(ANDROID_TOOLCHAIN)/sysroot/usr/lib" \
		-X -I"$(ANDROID_TOOLCHAIN)/sysroot/usr/include" \
		-X '-Wl,-Bstatic' -X '-lffi' -X '-lintl' -X '-liconv' $(VFLAG) \
		-X '-lgio-2.0' -X '-lgee-0.8' -X '-lglib-2.0' \
		-X '-Wl,-Bdynamic' -X '-llog' -X '-lc' -X '-lm' -X '-lz' -X '-ldl' -X '-lGLESv1_CM' -X '-lGLESv2' -X '-landroid' -X '-lstdc++' \
		--pkg sdl2-android
	
	# ANDROID USES SDL JNI CALLS
	JNI = 0
	
	VBASE += $(AVALANCHE_DIR)/sdks/avalanche/avalanche_android_main.c
	SHARED = 1
	OS = Android
	STRIP = $(ANDROID_TOOLCHAIN)/bin/$(ANDROID_PREFIX)-strip
else
	VFLAG += -X -lm
endif


ifeq ($(DEBUG), 1)
	VFLAG += --enable-gobject-tracing --enable-checking -g -D AVALANCHE_DEBUG
endif


ifeq ($(JNI), 1)
	VBASE += $(AVALANCHE_DIR)/sdks/avalanche/avalanche_jni.h
	VFLAG += -D AVALANCHE_JNI
	SHARED = 1
endif


ifeq ($(OS), Windows_NT)
	BIN =  ./bin/game.exe
	CLEAN := rm -f $(BIN)
	VFLAG += -X -mwindows -D AVALANCHE_WIN
else ifeq ($(OS), Android)
	VFLAG+= -D AVALANCHE_UNIX -D AVALANCHE_LINUX -D AVALANCHE_ANDROID
else
	UNAME := $(shell uname)
	ifeq ($(UNAME), Linux)
		BIN =  ./bin/game.elf
		VFLAG+= -D AVALANCHE_UNIX -D AVALANCHE_LINUX
	else ifeq ($(UNAME), Darwin)
		VFLAG+= -D AVALANCHE_UNIX -D AVALANCHE_DARWIN
	endif
endif


ifeq ($(SHARED), 1)
	VFLAG+= -X -shared
	ifeq ($(OS), Windows_NT)
		BIN =  ./bin/game.dll
	else ifeq ($(OS), Android)
		BIN =  ./bin/libgame-android.so
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
	$(STRIP) $(BIN)

clean: .PHONY
default: build
