/*
 *	This Source Code Form is subject to the terms of the Mozilla Public
 *	License, v. 2.0. If a copy of the MPL was not distributed with this
 *	file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 *													Copyright(C) 2013
 *									 Christian Ferraz Lemos de Sousa
 *											Pedro Henrique Lara Campos
 */

namespace Avalanche {

namespace Application {

	public class Main : Gtk.Window {

		private Gtk.Box box = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
		private GenericArray<Plugins.Tab> tab_list = new GenericArray<Plugins.Tab>(); // used to avoid tab destruction
		private Session session = Session.get_default();

		public static int main(string[] args) {
			// Gtk setup
			Gtk.init(ref args);
			Session.initialize();
			// TODO: dark theme as runtime setting
			#if (DARK_THEME)
			Gtk.Settings.get_default().gtk_application_prefer_dark_theme = true;
			#endif
			// Launch Avalanche
			Main application = new Main();
			application.show_all();
			Gtk.main();
			// No errors
			return 0;
		}

		public Main() {
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

		// Toolbar System
		private void setup_menu() {
			// Toobar setup
			Gtk.Toolbar toolbar = new Gtk.Toolbar ();
			toolbar.get_style_context ().add_class (Gtk.STYLE_CLASS_PRIMARY_TOOLBAR);
			Gtk.ToolButton open_button = new Gtk.ToolButton.from_stock (Gtk.Stock.OPEN);
			open_button.clicked.connect(open_project);
			open_button.is_important = true;
			toolbar.add (open_button);
			this.box.pack_start(toolbar, false, false);
		}

		private void open_project(){
			// Open project dialog
			OpenProjectDialog project_dialog = new OpenProjectDialog(); // todo: reuse a dynamic dialog system
			if (project_dialog.run() == Gtk.ResponseType.OK){
				// should try to get info from the project folder and also
				SList<string> uris = project_dialog.get_uris ();
				stdout.printf ("Selection:\n");
				foreach (unowned string uri in uris) {
					stdout.printf (" %s\n", uri);
				}
				project_dialog.close();
			}else {
				// Just cancell the action
				project_dialog.close();
			}
		}

		private void setup_tabs() {
			// Our default tab list.
			//add_tab(new Tabs.SourceEditor());
		}

		private void add_tab(Plugins.Tab tab) {
			// Adding tabs
			tab_list.add(tab);
			tab.show(this.box);
		}

	}
}

} // Avalanche
