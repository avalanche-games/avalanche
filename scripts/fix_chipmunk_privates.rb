##
#  This Source Code Form is subject to the terms of the Mozilla Public
#  License, v. 2.0. If a copy of the MPL was not distributed with this
#  file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
#                          Copyright(C) 2013
#                   Christian Ferraz Lemos de Sousa
#                      Pedro Henrique Lara Campos
##

["./chipmunk.vapi", "../sdks/vala/vapi/vala/chipmunk.vapi"].each do |file|
	if File.exists?(file)
		lines  = []
		IO.read(file).each_line do |line|
			ltmp = "#{line.rstrip}\n"
			lines << ltmp if ltmp.scan(/\_private\;$/).empty?
		end
		IO.write(file.gsub(/chipmunk/, "chipmunk.gen"), lines.join(""))
		break
	end
end
