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

	public class Project : Object {
		// Project folder
		private string _project_path = "";
		public string project_path {
			get { return _project_path; }
			set { _project_path = value; }
		}

		// Json things
		private Json.Generator generator = new Json.Generator();
    private Json.Node root = new Json.Node(Json.NodeType.OBJECT);
    private Json.Object project = new Json.Object();
    private Json.Object session = new Json.Object();
    private Json.Object root_obj = new Json.Object();

		// Project singleton variables
		static bool initialized = false;
		static Project single_instance;

		// Initialization Methods
		public static void initialize(){
			if (initialized == false) {
				single_instance = new Project();
				initialized = false;
			}
		}

		// Delivering the standard session
		public static Project get_default(){
			return single_instance;
		}

		// Forbid another session
		private Project() {
			size_t length;
			generator.indent_char = 9;
			generator.indent = 1;
			generator.pretty = true;
			root_obj.set_object_member("project", project);
			root_obj.set_object_member("session", session);
			root.set_object(root_obj);
			generator.set_root(root);
			string test = generator.to_data(out length);
			print(test);
		}

		// Loading a session from path
		public bool load_path(string path) {
			File file = File.new_for_path(path + "session.apj");
			return true;
		}

		public string session_to_json(){
			size_t length;
   		Json.Node _root = new Json.Node(Json.NodeType.OBJECT);
			Json.Generator gen = new Json.Generator();
			gen.set_root(_root);
			_root.set_object(session);
			return gen.to_data(out length);
		}

		public string project_to_json(){
			size_t length;
   		Json.Node _root = new Json.Node(Json.NodeType.OBJECT);
			Json.Generator gen = new Json.Generator();
			gen.set_root(_root);
			_root.set_object(project);
			return gen.to_data(out length);
		}

	} // Project

} // Application

}