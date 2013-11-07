# Copyright (c) 2013 Michael Dvorkin
#
# Unbelievable is freely distributable under the terms of MIT license.
# See LICENSE file or http://www.opensource.org/licenses/mit-license.php

$:.unshift File.realpath("#{File.dirname(__FILE__)}/../lib")
require "unbelievable"

stories = [ :todo, :secret, :lorem , :haiku ].map do |style|
  Unbelievable.style = style
  story = Unbelievable.generate(%Q/puts "Hello world! (#{style})";/)
  puts " Unbelievable #{style.capitalize} ".center(75, "=")
  puts story
  puts
  story
end

puts " stories.each { |story| eval story } ".center(75, "=")
stories.each { |story| eval story }
