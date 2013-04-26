# Avalanche
We're a team that was born from a group of developers that learned to programm while developing games,  our major goal is to make a engine that makes it easier, but without being so slow or limited like those we used way before. We also want it to be Free and Open Source.

Also, note that being Free and Open Source do not excludes the possibility of writing proprietary prfitable games, so we also make it ease to create such projects.

We also desire to create some games, and develop a community about Indie Game.

# Building

## General Requirements

You'll need to install these libraries to build any Avalanche thing:

* [GCC](http://gcc.gnu.org/)(Linux) or *[Mingw](http://www.mingw.org/) and [Ruby](http://rubyinstaller.org/)*(Windows)
* [vala](https://live.gnome.org/Vala/)
* [glib](https://developer.gnome.org/glib/)

Some already comes installed with most Linux, if not you can just install it with your package manager. On Windows you might need to hunt for binaries or build most libraries from source, also use rake to build the editor if you do not like headaches :P

We will add some AES library to this list when implementing cryptography, so keep your eyes open.

## Build Editor Requirements

To build the editor, also install:

* [libgee](https://live.gnome.org/Libgee)
* [gtk3](http://www.gtk.org/)
* [gtksourceview3](http://projects.gnome.org/gtksourceview/)
* [json-glib](https://live.gnome.org/JsonGlib/)

## Edit a Game

* [libgee](https://live.gnome.org/Libgee)\*
* [SDL 2](http://www.libsdl.org/hg.php)

\* We *may* use it, but I(Christian), for some reason, do not want to .-.

### Deploy on Linux
We, Linux developers, have some nice *installation* tools called package managers, they install all dependencies that another package needs automatically, so we have no reason to build anything statically, just make a package to your targeted distro and let the package manager do it's work, you should also release a tar.gz with the binaries and a makefile with a install/uninstall task (crossdistro release). 

### Deploy on Windows
On Windows our builds include every library you need, in the deploy tab you can choise if you will build the game statically or dynamically. Because of the LGPL coverage, you should use the dll model on Windows.

### Deploy on Mac
TODO

## Play a Game

### On Windows
To run the game you do not need anything, it already comes with your game.

### On Linux
Add Gtk3, Glib, libgee\* and SDL2\*\* to the package dependency list. 

\* We're not using libgee (for now). \*\* SDL2 will be included statically(On Linux) because SDL2 has no packages.

## Building the Editor

### Linux Easy Way
Open the Avalanche's source folder in a Terminal and run `make`, if everything is alright then `sudo make install`, you will be prompted to input your password to install the editor in the system, after that just search for avalanche in your desktop.

If you got some errors during the make process, double check if the dependencies are all right, then check if the last commit is building on travis, if it is so create a issue using our issues standards.

### Windows Easy Way
Just install the dependencies (I might add some help here), install Ruby open the terminal, type rake, if no rake command is found then make sure that ruby is in your path and then run `gem install rake`, after that go to the Avalanche's folder using *cd* and run `rake`, if everything succeeds now type `rake install`.

### Linux Hard Way \*\*UNSUPPORTED\*\*
Install Ruby19 (or higher) and the rake gem, use `gem install rake` if you do not have it installed. Now open the Avalanche's source folder in a Terminal and run `rake`, if everything is ok then run `sudo rake install`, you will be prompted to input your password to install the editor in the system, after that just search for avalanche in your desktop.

### Windows Hard Way \*\*UNSUPPORTED\*\*
Install Cygwin, MSYS or any *Gnu Tools* port for windows, open the custom terminal(that should be able to run shell/bash), open the Avalanche source folder and run `make`, then run `sudo make install`.

# Hacking

If you want to contribute to the project, first note that everything you pull to this project is copyrighted to the contributors. If you do not want to be a official contributor, just fork the project and pull your commits to the main repository, you should also keep our coding style:

<pre>
namespace A { // Root namespace on a fake '-1' identation level
// do not write 'using'
public class SintaxSample : Object { // Type is camel case, do not reffer to glib directly, but always reffer to others
	// Tabs instead of spaces
	public void x_e(int y, float x) {
		/* Comments on separated lines
		 * Any multi-lined comment over ** and any single over //
		 * Between 80 to 120 characters per line (even code)
		 * Identation: 1 Tab
		 */
		int z_a;
		// Space before every comment
		if(y > x) {
			// Explicit namespaces, no "using" statements 
			z_a = A.B.do_sth(x);
		// Space before every opening bracket
		}else {
			do_sth(y);
		} // This kind of comment for remembering what is being closed
		// If needed remember to do the correct usage of &\&&
	}
}// SintaxSample

public enum  SomeEnum {
	ALL_UPPER_CASE, WITH_UNDERSCORE
}// SomeEnum

}// A
</pre>

If you follow those styles guidelines your commit might be accepted.


##Problems


If something is bothering you, you should really create a issue here, we have no
restriction about the issues that you should create, but we ask you to:

Give information about your Operational System, GCC version, Vala version, and
everything you tried to do to fix the problem, if some commit added that
problem, you may also want to reffer to it.


###About Build Issues


You should avoid to create issues to unsupported ways of building the editor
(the hard way), and also, for build issues use a name like `Build Error on
Operational System - Details`, where Operational System is windows version,
mac version or linux distro name and version, the details is a thing that you
think that is causing the bug, no rules for descriptions (for now).


# Licensing

## Avalanche Editor


<pre>
  This Source Code Form is subject to the terms of the Mozilla Public
  License, v. 2.0. If a copy of the MPL was not distributed with this
  file, You can obtain one at http://mozilla.org/MPL/2.0/.
                                ---
                          Copyright(C) 2013
                   Christian Ferraz Lemos de Sousa
                      Pedro Henrique Lara Campos
</pre>


## Game Player

<pre>
                          Copyright(C) 2013
                   Christian Ferraz Lemos de Sousa
                      Pedro Henrique Lara Campos

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
</pre>
