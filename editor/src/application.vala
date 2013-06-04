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

namespace Application {

	public class Main : Gtk.Window {

		private Gtk.Notebook notebook = new Gtk.Notebook ();
		private Gtk.Box box = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
		private Gtk.Toolbar toolbar = new Gtk.Toolbar ();
		private GenericArray<Plugins.Tab> tab_list = new GenericArray<Plugins.Tab>(); // used to avoid tab destruction
		private Project project = Project.get_default();

		public static int main(string[] args) {
			// Gtk setup
			Gtk.init(ref args);
			Project.initialize();

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
		}

		private void setup() {
			setup_user();
			setup_menu();
			setup_toolbar();
			setup_notebook();
			this.add(this.box);
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
			// NOTE: this is temporary
			string location = "/.local/share/Avalanche/DebugProject/";
			// Creates the root
			try {
				File.new_for_path(Environment.get_home_dir() + location).make_directory_with_parents();
			}catch (Error err) {}
			// Creates a source folder
			try {
				File.new_for_path(Environment.get_home_dir() + location + "src/").make_directory_with_parents();
			}catch (Error err) {}
			// Adds a debug folder inside the source
			try {
				File.new_for_path(Environment.get_home_dir() + location + "src/sample-folder").make_directory_with_parents();
			}catch (Error err) {}
			// Creates a database folder
			try {
				File.new_for_path(Environment.get_home_dir() + location + "db/").make_directory_with_parents();
			}catch (Error err) {}
			// Creates a resource folder
			try {
				File.new_for_path(Environment.get_home_dir() + location + "res/").make_directory_with_parents();
			}catch (Error err) {}
			// Creates a sample script
			try {
				File.new_for_path(Environment.get_home_dir() + location + "src/sample-script.vala").create(FileCreateFlags.REPLACE_DESTINATION);
			}catch (Error err) {}
			// Creates another sample script
			try {
				File.new_for_path(Environment.get_home_dir() + location + "src/sample-folder/sample-script2.vala"
				                 ).create(FileCreateFlags.REPLACE_DESTINATION);
			}catch (Error err) {}
		}

		// Toolbar System
		private void setup_toolbar() {
			// Toolbar configs
			this.toolbar.get_style_context().add_class(Gtk.STYLE_CLASS_PRIMARY_TOOLBAR);

			// Toolbar buttons
			Gtk.ToolButton open_button = new Gtk.ToolButton.from_stock(Gtk.Stock.OPEN);
			open_button.clicked.connect(open_project);
			open_button.is_important = true;

			// Adding toolbar
			this.toolbar.add(open_button);
			this.box.pack_start(toolbar, false, false);
		}

		private void setup_menu() {

		}

		private void setup_notebook() {
			this.notebook.tab_pos = Gtk.PositionType.BOTTOM;
			this.box.pack_start(notebook, true, true);
		}

		private void setup_tabs() {
			// Our default tab list.
		}

		public void base_menu() {
		}

		private void open_project(){
			// Open project dialog
			OpenDialog project_dialog = new OpenDialog("*.avalproject");
			if (project_dialog.run() == Gtk.ResponseType.ACCEPT){
				File file = File.new_for_uri(project_dialog.get_uris().nth(0).data);
				Project.get_default().project_path = file.get_parent().get_path();
			}
			project_dialog.close();
			add_tab(new Plugins.Scripting.TabPlugin());
		}

		private void add_tab(Plugins.Tab tab) {
			// Adding tabs
			tab_list.add(tab);
			tab.show(this.notebook);
		}

	}
}

} // Avalanche
