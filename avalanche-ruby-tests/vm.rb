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
require_relative 'bytecode'

module Avalanche
  class VirtualMachine
    def verb msg;  print "#{msg}\n" if @verbose;  end

    def initialize bytecode = Bytecode.new
      @verbose  = false
      @bytecode = bytecode
      @boolean  = Array.new(32768) { false }
      @integer  = Array.new(32768) { 0     }
      @float    = Array.new(32768) { 0.0   }
      @string   = Array.new(32768) { ""    }
      #@pictures = Hash.new
    end

    def run verbose = :nil
      @verbose = verbose unless verbose == :nil
      verb "#{@bytecode.inspect}"
      time = Time.now if @verbose
      check @bytecode
      puts "\nExecuted in #{Time.now - time} seconds." if @verbose
    end

    def check bytecode
      flags = Hash.new

      flags[:break] = false

      if bytecode.is_a_container?
        # containers and condition bytecodes
        check = true
        case bytecode.type
        when Type::Container
          check = true
        when Type::IfInt
          check = false unless (@integer[bytecode.args[0]] == bytecode.args[1])
        when Type::IfIntInt
          check = false unless (@integer[bytecode.args[0]] == @integer[bytecode.args[1]])
        when Type::IfStr
          check = false unless (@string[bytecode.args[0]] == bytecode.args[1])
        when Type::IfStrStr
          check = false unless (@string[bytecode.args[0]] == @string[bytecode.args[1]])
        else
          check = false
        end
        bytecode.each {|bc| check bc } if check
      else
        # command bytecodes
        case bytecode.type
        when Type::Break
          if flags[:break]
          end
        when Type::OpBool #TODO: OpDbBool
          case bytecode.args[1]
          when Int::Equal
            @boolean[bytecode.args[0]]  = bytecode.args[2]
          when Int::Invert
            @boolean[bytecode.args[0]]  = @boolean[bytecode.args[0]]
          when Int::Compare
            case bytecode.args[2]
            when 0 # to a value
              @boolean[bytecode.args[0]]= (@boolean[bytecode.args[0]] == bytecode.args[3])
            when 1 # to another boolean var
              @boolean[bytecode.args[0]]= (@boolean[bytecode.args[0]] == @boolean[bytecode.args[3]])
            end
          end
        when Type::OpInt #TODO: OpDbInt
          case bytecode.args[1]
          when Int::Equal
            @integer[bytecode.args[0]]  = bytecode.args[2]
          when Int::Plus
            @integer[bytecode.args[0]] += bytecode.args[2]
          when Int::Minus
            @integer[bytecode.args[0]] -= bytecode.args[2]
          when Int::Multiply
            @integer[bytecode.args[0]] *= bytecode.args[2]
          when Int::Divide
            @integer[bytecode.args[0]] /= bytecode.args[2]
          when Int::Power
            @integer[bytecode.args[0]] = @integer[bytecode.args[0]]**bytecode.args[2]
          when Int::Left
            @integer[bytecode.args[0]] = @integer[bytecode.args[0]] % bytecode.args[2]
          when Int::AnyRoot
            @integer[bytecode.args[0]] = (@integer[bytecode.args[0]]**(1.0/bytecode.args[2].to_f)).to_i
          end
        when Type::OpFloat #TODO: OpDbFloat
          case bytecode.args[1]
          when OpFloat::Equal
            @float[bytecode.args[0]]  = bytecode.args[2]
          when OpFloat::Plus
            @float[bytecode.args[0]] += bytecode.args[2]
          when OpFloat::Minus
            @float[bytecode.args[0]] -= bytecode.args[2]
          when OpFloat::Multiply
            @float[bytecode.args[0]] *= bytecode.args[2]
          when OpFloat::Divide
            @float[bytecode.args[0]] /= bytecode.args[2]
          when OpFloat::Power
            @float[bytecode.args[0]] =  @float[bytecode.args[0]]**bytecode.args[2]
          when OpFloat::Left
            @float[bytecode.args[0]] =  @float[bytecode.args[0]] % bytecode.args[2]
          when OpFloat::AnyRoot
            @float[bytecode.args[0]] = (@float[bytecode.args[0]]**(1.0/bytecode.args[2].to_f)).to_i
          end
        when Type::OpStr #TODO: OpDbStr
          case bytecode.args[1]
          when Str::Equal
            @string[bytecode.args[0]] = bytecode.args[2]
          when Str::Concat
            @string[bytecode.args[0]] << bytecode.args[2]
          when Str::Repeat
            @string[bytecode.args[0]] = @string[bytecode.args[0]]*bytecode.args[2]
          when Str::Gsub
            @string[bytecode.args[0]].gsub!(Regexp.new(bytecode.args[2]))
          end
        # convert bool operations
        when Type::ConvBoolInt
        when Type::ConvBoolFloat
        when Type::ConvBoolStr
        # convert another operations
        when Type::ConvIntFloat
        when Type::ConvFloatInt
        # parsing operations
        when Type::ParseIntStr
        when Type::ParseStrFloat
        when Type::ParseStrInt
        when Type::ParseFloatStr
        # console output
        when Type::ConOutDynamic
          case bytecode.args[0]
          when 0
            puts @integer[bytecode.args[1]]
          end
        end
      end
    end
  end
end
