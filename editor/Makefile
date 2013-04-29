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
VFLAG = -X '-lm' -X -O3 -D $(OSNAME)
VPKGS = --pkg gio-2.0 --pkg json-glib-1.0 --pkg gtk+-3.0 --pkg gtksourceview-3.0 --pkg gee-0.8
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

ifeq ($(OSNAME),Linux)
	BUILD   := mkdir "../bin" 2>/dev/null; true && $(VALAC) $(VPKGS) $(VFLAG) $(SRC) -o $(BIN)
	INSTALL := @echo "Preparing to install..." 2>/dev/null; true &&
	INSTALL := mkdir "/usr/" 2>/dev/null; true &&
	INSTALL := $(INSTALL) mkdir "/usr/bin/" 2>/dev/null; true &&
	INSTALL := $(INSTALL) mkdir "/usr/lib/" 2>/dev/null; true &&
	INSTALL := $(INSTALL) mkdir "/usr/local/" 2>/dev/null; true &&
	INSTALL := $(INSTALL) mkdir "/usr/local/share/" 2>/dev/null; true &&
	INSTALL := $(INSTALL) mkdir "/usr/local/share/applications/" 2>/dev/null; true &&
	INSTALL := $(INSTALL) echo -e "\nCreating directories..." &&
	INSTALL := $(INSTALL) echo -e "mkdir \"/usr/lib/avalanche/\"" &&
	INSTALL := $(INSTALL) mkdir "/usr/lib/avalanche/"; true &&
	INSTALL := $(INSTALL) echo -e "mkdir \"/usr/lib/avalanche/icons/\"" &&
	INSTALL := $(INSTALL) mkdir "/usr/lib/avalanche/syntax-colors/"; true &&
	INSTALL := $(INSTALL) echo -e "mkdir \"/usr/lib/avalanche/icons/\"" &&
	INSTALL := $(INSTALL) mkdir "/usr/lib/avalanche/icons/"; true &&
	INSTALL := $(INSTALL) echo -e "\nInstalling files..." &&
	INSTALL := $(INSTALL) cp -f $(BIN) "/usr/bin/avalanche" &&
	INSTALL := $(INSTALL) cp -f "./res/syntax-colors/tonight.xml" "/usr/lib/avalanche/syntax-colors/tonight.xml" &&
	INSTALL := $(INSTALL) cp -f "./res/icons/avalanche.png" "/usr/lib/avalanche/icons/avalanche.png" &&
	INSTALL := $(INSTALL) cp -f "./res/icons/folder.png" "/usr/lib/avalanche/icons/folder.png" &&
	INSTALL := $(INSTALL) cp -f "./res/icons/vala.png" "/usr/lib/avalanche/icons/vala.png" &&
	INSTALL := $(INSTALL) cp -f "./res/shortcuts/avalanche.desktop" "/usr/local/share/applications/avalanche.desktop"
	REMOVE  := @echo "Removing Avalanche from the system..." 2>/dev/null; true &&
	REMOVE  := $(REMOVE) rm -f "/usr/bin/avalanche"; true &&
	REMOVE  := $(REMOVE) rm -f "/usr/lib/avalanche/syntax-colors/tonight.xml"; true &&
	REMOVE  := $(REMOVE) rm -f "/usr/lib/avalanche/icons/avalanche.png"; true &&
	REMOVE  := $(REMOVE) rm -f "/usr/lib/avalanche/icons/folder.png" &&
	REMOVE  := $(REMOVE) rm -f "/usr/lib/avalanche/icons/vala.png" &&
	REMOVE  := $(REMOVE) rm -f "/usr/local/share/applications/avalanche.desktop"; true &&
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
