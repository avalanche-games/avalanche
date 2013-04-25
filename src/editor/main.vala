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

	private Gtk.Notebook notebook = new Gtk.Notebook();
	private GenericArray<Tabs.Base> tab_list = new GenericArray<Tabs.Base>(); // used to avoid tab destruction

	public Application() {
		setup();
		setup_tabs();
		this.add(this.notebook);
	}

	private void setup() {
		// Adjusts the main window
		this.title = "Avalanche";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.hide_titlebar_when_maximized = true;
		this.destroy.connect(Gtk.main_quit);
		this.set_default_size(800, 800);
		// Notebook properties
		this.notebook.set_scrollable(true);
		this.notebook.tab_pos = Gtk.PositionType.TOP;
		this.notebook.popup_enable();
		// Try to load avalanche icon
		try {
			this.icon = Gtk.IconTheme.get_default().load_icon("avalanche", 512, 0);
		} catch(Error e) {
			try {
				this.icon = new Gdk.Pixbuf.from_file("avalanche.png");
			} catch(Error e) {
				stderr.printf("Could not load application icon: %s\n", e.message);
			}
		}
	}

	private void setup_tabs() {
		// Our default tab list.
		add_tab(new Tabs.SourceEditor());
	}

	private void add_tab(Tabs.Base tab) {
		// Adding tabs
		tab_list.add(tab);
		tab.setup(this.notebook);
	}
} // class:Application

public static int main(string[] args) {
	// Gtk setup
	Gtk.init(ref args);
	Gtk.Settings.get_default().gtk_application_prefer_dark_theme = true;
	// Application launch
	Application avalanche = new Application();
	avalanche.show_all();
	Gtk.main();
	return 0;
}

} // Avalanche
