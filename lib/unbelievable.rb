require "unbelievable/core_ext/array"
require "unbelievable/generator"
require "unbelievable/buzzwords"
require "unbelievable/haiku"
require "unbelievable/lorem"

$code, $missing = [], []
$generator = false
module Unbelievable
  extend self
  attr_accessor :style

  def generate(code, style = nil)
    $generator = true
    style ||= @style || :lorem
    unless [ :buzzwords, :lorem, :haiku ].include?(style)
      raise ArgumentError, "style must be :buzzwords, :lorem, or :haiku"
    else
      chars = code.unpack("C*")
      encoded = sprintf("%03o" * chars.size, *chars).unpack("C*").map{ |n| n - 45 }
      generator = Object.const_get("#{self}::#{style.capitalize}")
      puts "generator: #{generator}"
      puts "generator: #{generator.class}"
      generator.new.paragraph(*encoded)
    end
  ensure
    $generator = false
  end
end


# src = 'puts "Hello world!"'
# chars = src.unpack("C*")
# puts chars.inspect
# puts sprintf("%03o" * chars.size, *chars)
# sizes = sprintf("%03o" * chars.size, *chars).unpack("C*").map{ |n| n - 45 }
# puts sizes.inspect
# puts Unbelievable::Buzzwords.new.paragraph(*sizes)
# [4, 9, 3, 4, 9, 8, 4, 9, 7, 4, 9, 6, 3, 7, 3, 3, 7, 5, 4, 4, 3, 4, 7, 8, 4, 8, 7, 4, 8, 7, 4, 8, 10, 3, 7, 3, 4, 9, 10, 4, 8, 10, 4, 9, 5, 4, 8, 7, 4, 7, 7, 3, 7, 4, 3, 7, 5]

def method_missing(name, *args)
  # puts "MISSING: #{self.class.inspect} => #{self.inspect}"
  # puts "MISSING: #{name}: #{args}, #{$missing.inspect}"
  return super if $generator

  if args.empty? && $missing.any?
    $code.concat($missing.reverse)
    $missing.clear
  end
  $missing << (name.to_s.size - 1).to_s
end

def Object.const_missing(name)
  send(name.downcase)
end

at_exit do
  $code.concat($missing.reverse)
  # puts $missing.reverse
  # puts "code: " + $code.inspect
  # puts "scan: " + $code.join.scan(/.../).inspect
  # puts "pack: " + $code.join.scan(/.../).map { |o| o.bytes.map { |n| n - 2 }.pack("C*") }.inspect
  # puts "i(8): " + $code.join.scan(/.../).map { |o| o.bytes.map { |n| n - 2 }.pack("C*").to_i(8) }.inspect
  eval $code.join.scan(/.../).map { |o| o.bytes.map { |n| n - 2 }.pack("C*").to_i(8).chr }.join
end
