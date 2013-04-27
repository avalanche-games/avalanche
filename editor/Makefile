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
VFLAG = -X '-lm' -X -O3
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
	BUILD := $(VALAC) $(VPKGS) $(VFLAG) $(SRC) -o $(BIN)
	INSTALL := @echo "Preparing to install..."\
	@mkdir "/usr/" 2>/dev/null; true\
	@mkdir "/usr/bin/" 2>/dev/null; true\
	@mkdir "/usr/lib/" 2>/dev/null; true\
	@mkdir "/usr/local/" 2>/dev/null; true\
	@mkdir "/usr/local/share/" 2>/dev/null; true\
	@mkdir "/usr/local/share/applications/" 2>/dev/null; true\
	@echo -e "\nCreating directories..."\
	@echo -e "mkdir \"/usr/lib/avalanche/\""\
	@mkdir "/usr/lib/avalanche/"; true\
	@echo -e "mkdir \"/usr/lib/avalanche/icons/\""\
	@mkdir "/usr/lib/avalanche/syntax-colors/"; true\
	@echo -e "mkdir \"/usr/lib/avalanche/icons/\""\
	@mkdir "/usr/lib/avalanche/icons/"; true\
	@echo -e "\nInstalling files..."\
	cp -f $(BIN) "/usr/bin/avalanche"\
	cp -f "./res/syntax-colors/tonight.xml" "/usr/lib/avalanche/syntax-colors/tonight.xml"\
	cp -f "./res/icons/avalanche.png" "/usr/lib/avalanche/icons/avalanche.png"\
	cp -f "./res/shortcuts/avalanche.desktop" "/usr/local/share/applications/avalanche.desktop"
	REMOVE := rm -f "/usr/bin/avalanche"\
	rm -f "/usr/lib/avalanche/syntax-colors/tonight.xml"\
	rm -f "/usr/lib/avalanche/icons/avalanche.png"\
	rm -f "/usr/local/share/applications/avalanche.desktop"\
	rmdir "/usr/lib/avalanche/syntax-colors/"\
	rmdir "/usr/lib/avalanche/icons/"\
	rmdir "/usr/lib/avalanche/"
	CLEAN := rm -f $(BIN)

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
