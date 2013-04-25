#!/usr/bin/env ruby
# encoding: utf-8
#----------------------------------------------------------------------------------------------------------------------
# The MIT License (MIT)
#
# Copyright (c) 2013 Christian Ferraz Lemos de Sousa
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
# documentation files (the "Software"), to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all copies or substantial portions of the
# Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
# WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS
# OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
# OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#----------------------------------------------------------------------------------------------------------------------

require_relative 'enum_rb'
require_relative 'commands'

module Avalanche
  class Bytecode
    attr_reader :type, :args

    def initialize(type = Type::Container, *args)
      @type = type
      @args = args
      @container = false
      @container = true if [Type::Container,
                            Type::IfInt, Type::IfIntInt,
                            Type::IfStr, Type::IfStrStr].include? @type
      @holding = []
      @holding = Bytecode.new(Type::Nothing) if !(@type == Type::Nothing) && !(@container)
    end

    def is_a_container?
      return @container
    end

    def inspect(size="")
      return "" if @type == Type::Nothing
      out  = "0x#{@type.to_s(16)} : #{@args.join(" ")};\n"
      if @container
        size += "  "
        @holding.each do |a|
          out += "#{size}#{a.inspect(size)}"
        end
      end
      return out
    end

    def each; @holding.each{|*args| yield(*args)}; end
    def type;  return @type;  end
    def holding;  return @hold;  end
    def <<(v);  @holding << v;  end
    def [](i);  @holding[i];  end
    def []=(i, value);  @holding[i] = value;  end
    def last;  @holding.last;  end
  end
end
