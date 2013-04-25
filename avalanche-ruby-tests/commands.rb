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

module Avalanche
  # Bytecode Commands
  Type = Enum.new(:Nothing, :Comment, :Mark, :Container, :Event, :Page, :Loop, :IfInt, :IfIntInt,
                  :IfBool, :IfBoolBool,:IfStr,:IfStrStr,:IfDbInt,:IfDbIntInt, :IfDbStrStr, :DoIf,
                  :Else,:WhileInt,:WhileIntInt,:WhileBool, :WhileBoolBool,:WhileStr,:WhileStrStr,
                  :WhileDbInt,:WhileDbIntInt,:WhileDbBool,:WhileDbBoolBool,:ConOutInt,:ConOutStr,
                  :ConOutBool,   :ConOutDynamic,   :ConOutDbInt,   :ConOutDbStr,   :ConOutDbBool,
                  :ConOutDbDynamic,:OpBool,:OpInt,:OpFloat, :OpStr,:OpDbBool,:OpDbInt,:OpDbFloat,
                  :OpDbStr, :Break,  :ConvBoolInt,  :ConvBoolFloat,  :ConvBoolStr, :ConvIntFloat,
                  :ConvFloatInt, :ParseIntStr, :ParseStrFloat, :ParseStrInt,  :ParseFloatStr,   :SpawnCharacter,
                  :ChangeEvent, :BindShape)

  # Boolean Operations
  Bool = Enum.new(:Equal, :Invert, :Compare)

  # Int Operations
  Int  = Enum.new(:Equal, :Plus, :Minus, :Multiply, :Divide, :Power, :Left, :AnyRoot)

  # Float Operations
  Float= Enum.new(:Equal, :Plus, :Minus, :Multiply, :Divide, :Power, :Left, :AnyRoot)

  # String Operations
  Str  = Enum.new(:Equal, :Concat, :Repeat, :Gsub)

end
