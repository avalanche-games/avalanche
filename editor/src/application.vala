/*
 *  This Source Code Form is subject to the terms of the Mozilla Public
 *  License, v. 2.0. If a copy of the MPL was not distributed with this
 *  file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 *                          Copyright(C) 2013
 *                   Christian Ferraz Lemos de Sousa
 *                      Pedro Henrique Lara Campos
 */

namespace Avalanche {

public class Application : Gtk.Window {

	//private Gtk.Notebook notebook = new Gtk.Notebook();
	private Gtk.Box box = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
	private GenericArray<Tabs.Base> tab_list = new GenericArray<Tabs.Base>(); // used to avoid tab destruction

	public Application() {
		// Another settings
		setup();
		this.add(this.box);
	}

	private void setup() {
		setup_user();
		setup_menu();
		setup_tabs();
		// Adjusts the main window
		this.title = "Avalanche";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.hide_titlebar_when_maximized = true;
		this.destroy.connect(Gtk.main_quit);
		this.set_default_size(800, 800);
		// Try to load avalanche icon
		try {
			this.icon = Gtk.IconTheme.get_default().load_icon("avalanche", 512, 0);
		} catch(Error e) {
			try {
				this.icon = new Gdk.Pixbuf.from_file("/usr/lib/avalanche/icons/avalanche.png");
			} catch(Error e) {
				stderr.printf("Could not load application icon: %s\n", e.message);
			}
		}
	}

	private void setup_user() {
		// NOTE: Temporary
		string location = "/.local/share/Avalanche/";
		try {
			File.new_for_path(Environment.get_home_dir() + location
			                 ).make_directory_with_parents();
		}catch (Error err) {}
		try {
			File.new_for_path(Environment.get_home_dir() + location + "DebugProject/src/sample-folder"
			                 ).make_directory_with_parents();
		}catch (Error err) {}
		try {
			File.new_for_path(Environment.get_home_dir() + location + "DebugProject/db/"
			                 ).make_directory_with_parents();
		}catch (Error err) {}
		try {
			File.new_for_path(Environment.get_home_dir() + location + "DebugProject/res/"
			                 ).make_directory_with_parents();
		}catch (Error err) {}
		try {
			File.new_for_path(Environment.get_home_dir() + location + "DebugProject/src/sample-script"
			                 ).create(FileCreateFlags.REPLACE_DESTINATION);
		}catch (Error err) {}
		try {
			File.new_for_path(Environment.get_home_dir() + location + "DebugProject/src/sample-folder/sample-script2"
			                 ).create(FileCreateFlags.REPLACE_DESTINATION);
		}catch (Error err) {}
	}

	private void setup_menu() {
		// Toobar setup
		Gtk.Toolbar toolbar = new Gtk.Toolbar ();
		toolbar.get_style_context ().add_class (Gtk.STYLE_CLASS_PRIMARY_TOOLBAR);
		Gtk.ToolButton open_button = new Gtk.ToolButton.from_stock (Gtk.Stock.OPEN);
		open_button.is_important = true;
        toolbar.add (open_button);
		this.box.pack_start(toolbar, false, false);
	}

	private void setup_tabs() {
		// Our default tab list.
		add_tab(new Tabs.SourceEditor());
	}

	private void add_tab(Tabs.Base tab) {
		// Adding tabs
		tab_list.add(tab);
		tab.show_at(this.box);
	}
} // class:Application

} // Avalanche
