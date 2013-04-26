# encoding: utf-8
# Copyright (C) 2013 - Avalanche Project
VALAC = "valac"
P_BIN = "./bin/samplegame"
P_SRC = Dir["./src/player/*.vala"]
P_PKG = "--pkg sdl --pkg sdl-gfx --pkg json-glib-1.0"
P_OPT = "-X -lSDL_gfx"
E_BIN = "./bin/avalanche"
E_SRC = Dir["./src/editor/*.vala"]
E_PKG = "--pkg gio-2.0 --pkg json-glib-1.0 --pkg gtk+-3.0 --pkg gtksourceview-3.0 --pkg gee-0.8 -X -lm"
E_OPT = ""

task(:editor)  { sh_do [VALAC, E_PKG, E_OPT, E_SRC.join(" "), "-o", E_BIN].join(" ") }
task(:player)  { sh_do [VALAC, P_PKG, P_OPT, P_SRC.join(" "), "-o", P_BIN].join(" ") }
task(:clean)   { sh_do ["rm", "-f", E_BIN, P_BIN].join(" ") }
task(:arch)    { puts "to build/run you must install `glib, libgee, gtk3, gtksourceview3, json-glib`:\n  pacman -S glib libgee gtk3 gtksourceview3 json-glib" }
task(:all)     { Rake::Task[:editor].invoke;	Rake::Task[:player].invoke }
task(:default) { Rake::Task[:editor].invoke }
def sh_do command; puts command; system command; end
