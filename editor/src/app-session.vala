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

	public class Session : Object {
		// Project folder
		private string _project_path = "";
		public string project_path {
			get { return _project_path; }
			set { _project_path = value; }
		}

		// Json things
		private Json.Generator generator = new Json.Generator();
    private Json.Node root = new Json.Node(Json.NodeType.OBJECT);
    private Json.Object object = new Json.Object();

		// Session singleton variables
		static bool initialized = false;
		static Session single_instance;

		// Initialization Methods
		public static void initialize(){
			if (initialized == false) {
				single_instance = new Session();
				initialized = false;
			}
		}

		// delivering the standard session
		public static Session get_default(){
			return single_instance;
		}

		// Forbid another session
		private Session() {
			size_t length;
			//var args = new Json.Object();
			generator.indent_char = 9;
			generator.indent = 1;
			generator.pretty = true;
			object.set_string_member("project", "dummy");//set_object_member("project", "dummy");
			root.set_object(object);
			generator.set_root(root);
			string test = generator.to_data(out length);
			print(test);
		}

		// Loading a session from path
		public bool load_path(string path) {
			File file = File.new_for_path(path + "session.avl");
			return true;
		}

		public string to_json(){
			// should convert the current session to json
			return "";
		}

	} // Session

} // Application

}