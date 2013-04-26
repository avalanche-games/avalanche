# encoding: utf-8
##
#  This Source Code Form is subject to the terms of the Mozilla Public
#  License, v. 2.0. If a copy of the MPL was not distributed with this
#  file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
#                          Copyright(C) 2013
#                   Christian Ferraz Lemos de Sousa
#                      Pedro Henrique Lara Campos
##

require "fileutils"
def sh command; puts command; system command; end

VALAC = "valac"
P_BIN = "./bin/samplegame"
P_SRC = Dir["./src/player/*.vala"]
P_PKG = "--pkg sdl --pkg sdl-gfx --pkg json-glib-1.0"
P_OPT = "-X -lSDL_gfx"
E_BIN = "./bin/avalanche"
E_SRC = Dir["./src/editor/*.vala"]
E_PKG = "--pkg gio-2.0 --pkg json-glib-1.0 --pkg gtk+-3.0 --pkg gtksourceview-3.0 --pkg gee-0.8 -X -lm"
E_OPT = ""

task(:install) {
  check_dirs = ["/usr/", "/usr/bin/", "/usr/lib/", "/usr/lib/avalanche/", "/usr/lib/avalanche/syntax-colors/",
                "/usr/lib/avalanche/icons/", "/usr/local/", "/usr/local/share/", "/usr/local/share/applications/"]
  check_dirs.each do |dir|
    unless File.directory? dir
      begin
        FileUtils.mkdir dir
      rescue Exception => e
        puts "Failed to create `#{dir}` directory:"
        puts "  #{e.message}\n\n"
      end
    end
  end
  copy_list = [["./bin/avalanche","/usr/bin/avalanche"],["./res/syntax-colors/tonight.xml",
                "/usr/lib/avalanche/syntax-colors/tonight.xml"],["./res/icons/avalanche.png",
                "/usr/lib/avalanche/icons/avalanche.png"],["./res/shortcuts/avalanche.desktop",
                "/usr/local/share/applications/avalanche.desktop"]]
  copy_list.each do |src, dest|
    begin
      puts "Updating #{dest}..." if File.exist? dest
      FileUtils.cp src, dest
    rescue Exception => e
      puts "Failed to install #{src} to #{dest}:"
        puts "  #{e.message}\n\n"
    end
  end
}

task(:uninstall) {
  delete_list = ["/usr/bin/avalanche","/usr/lib/avalanche/syntax-colors/tonight.xml",
                 "/usr/lib/avalanche/icons/avalanche.png","/usr/local/share/applications/avalanche.desktop"]
  delete_list.each do |file|
    begin
      if File.exist? file
      	puts "Removing #{file}..."
      	File.delete file
      else
        puts "File #{file} not found..."
      end
    rescue Exception => e
      puts "Failed to remove file #{file}:"
      puts "  #{e.message}\n\n"
    end
  end
  check_dirs = ["/usr/lib/avalanche/syntax-colors/", "/usr/lib/avalanche/icons/", "/usr/lib/avalanche/"]
  check_dirs.each do |dir|
    if File.directory? dir
      begin
        FileUtils.rmdir dir
      rescue Exception => e
        puts "Failed to remove `#{dir}` directory:"
        puts "  #{e.message}\n\n"
      end
    end
  end
}

task(:editor)  { sh [VALAC, E_PKG, E_OPT, E_SRC.join(" "), "-o", E_BIN].join(" ") }
task(:player)  { sh [VALAC, P_PKG, P_OPT, P_SRC.join(" "), "-o", P_BIN].join(" ") }
task(:clean)   { sh ["rm", "-f", E_BIN, P_BIN].join(" ") }
task(:arch)    { puts "to build/run you must install `glib, libgee, gtk3, gtksourceview3, json-glib`:\n  pacman -S glib libgee gtk3 gtksourceview3 json-glib" }
task(:all)     { Rake::Task[:editor].invoke;	Rake::Task[:player].invoke }
task(:default) { Rake::Task[:editor].invoke }
