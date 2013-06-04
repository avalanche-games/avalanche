##
#  This Source Code Form is subject to the terms of the Mozilla Public
#  License, v. 2.0. If a copy of the MPL was not distributed with this
#  file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
#                          Copyright(C) 2013
#                   Christian Ferraz Lemos de Sousa
#                      Pedro Henrique Lara Campos
##

# Defaul options
DARK_THEME = false

# Vala configs
VALAC = valac
VFLAG = -X '-lm' -X -O3 -D $(OSNAME)
VPKGS = --pkg json-glib-1.0 --pkg gtk+-3.0 --pkg gtksourceview-3.0
SRC = ./$(wildcard src/*.vala)
BIN = ../bin/avalanche

ifeq ($(OS), Windows_NT)
	OSNAME = Window_NT
	VFLAG += -X -mwindows
else
	UNAME := $(shell uname)
	ifeq ($(UNAME), Linux)
		OSNAME = Linux
	endif
	ifeq ($(UNAME), Darwin)
		OSNAME = Darwin
	endif
endif


# Option parsing
ifeq ($(DARK_THEME), true)
	VFLAG += -D DARK_THEME
endif

ifeq ($(OSNAME),Linux)
	BUILD   := mkdir "../bin" 2>/dev/null; true && $(VALAC) $(VPKGS) $(VFLAG) $(SRC) -o $(BIN)
	INSTALL := @echo "Preparing to install..." 2>/dev/null; true &&
	INSTALL := $(INSTALL) echo -e "Creating directories..." &&
	INSTALL := $(INSTALL) mkdir -p "/usr/lib/avalanche/syntax-colors/"; true &&
	INSTALL := $(INSTALL) mkdir -p "/usr/lib/avalanche/icons/"; true &&
	INSTALL := $(INSTALL) echo -e "Installing files..." &&
	INSTALL := $(INSTALL) cp -f $(BIN) "/usr/bin/avalanche" &&
	INSTALL := $(INSTALL) cp -f "./res/syntax-colors/tonight.xml" "/usr/lib/avalanche/syntax-colors/tonight.xml" &&
	INSTALL := $(INSTALL) cp -f "./res/syntax-colors/tonight.xml" "/usr/lib/avalanche/syntax-colors/tomorrow.xml" &&
	INSTALL := $(INSTALL) cp -f "./res/icons/avalanche.png" "/usr/lib/avalanche/icons/avalanche.png" &&
	INSTALL := $(INSTALL) cp -f "./res/icons/folder.png" "/usr/lib/avalanche/icons/folder.png" &&
	INSTALL := $(INSTALL) cp -f "./res/icons/vala.png" "/usr/lib/avalanche/icons/vala.png" &&
	INSTALL := $(INSTALL) cp -f "./res/shortcuts/avalanche.desktop" "/usr/share/applications/avalanche.desktop"
	REMOVE  := @echo "Removing Avalanche from the system..." 2>/dev/null; true &&
	REMOVE  := $(REMOVE) rm -f "/usr/bin/avalanche"; true &&
	REMOVE  := $(REMOVE) rm -f "/usr/lib/avalanche/syntax-colors/tonight.xml"; true &&
	REMOVE  := $(REMOVE) rm -f "/usr/lib/avalanche/syntax-colors/tomorrow.xml"; true &&
	REMOVE  := $(REMOVE) rm -f "/usr/lib/avalanche/icons/avalanche.png"; true &&
	REMOVE  := $(REMOVE) rm -f "/usr/lib/avalanche/icons/folder.png" &&
	REMOVE  := $(REMOVE) rm -f "/usr/lib/avalanche/icons/vala.png" &&
	REMOVE  := $(REMOVE) rm -f "/usr/share/applications/avalanche.desktop"; true &&
	REMOVE  := $(REMOVE) rmdir "/usr/lib/avalanche/syntax-colors/"; true &&
	REMOVE  := $(REMOVE) rmdir "/usr/lib/avalanche/icons/"; true &&
	REMOVE  := $(REMOVE) rmdir "/usr/lib/avalanche/"; true
	CLEAN   := rm -f $(BIN) && rmdir "../bin"
else ifeq ($(OSNAME),Darwin)
	@echo "We're still adding Mac OS support, support us by sending issues \`OSNAME=Linux\`."
else ifeq ($(OSNAME),Windows_NT)
	BUILD := $(VALAC) $(VPKGS) $(VFLAG) $(SRC) -o $(BIN)
endif

.PHONY:
	$(CLEAN)

build:
	$(BUILD)

install:
	$(INSTALL)

uninstall:
	$(REMOVE)

clean: .PHONY
default: build
