require "unbelievable/core_ext/array"
require "unbelievable/generator"
require "unbelievable/buzzwords"
require "unbelievable/haiku"
require "unbelievable/lorem"

$unbelievable = { code: [], missing: [], passthrough: false }

module Unbelievable
  extend self
  attr_accessor :style

  def generate(code, style = nil)
    with_method_missing do
      style ||= @style || :lorem
      unless [ :buzzwords, :haiku, :lorem ].include?(style)
        raise ArgumentError, "style must be :buzzwords, :haiku, or :lorem but not #{style.inspect}"
      else
        chars = code.unpack("C*")
        encoded = sprintf("%03o" * chars.size, *chars).unpack("C*").map{ |n| n - 45 }
        generator = Object.const_get("#{self}::#{style.capitalize}")
        generator.new.paragraph(*encoded)
      end
    end
  end

  private

  def with_method_missing(&blk)
    $unbelievable[:passthrough] = true
    yield
  ensure
    $unbelievable[:passthrough] = false
  end
end

def method_missing(name, *args)
  # puts "MISSING: #{self.class.inspect} => #{self.inspect}"
  # puts "MISSING: #{name}: #{args}, #{$unbelievable[:missing].inspect}"
  return super if $unbelievable[:passthrough]

  if args.empty? && $unbelievable[:missing].any?
    $unbelievable[:code].concat($unbelievable[:missing].reverse)
    $unbelievable[:missing].clear
  end
  $unbelievable[:missing] << (name.to_s.size - 1).to_s
end

def Object.const_missing(name)
  send(name.downcase)
end

at_exit do
  $unbelievable[:code].concat($unbelievable[:missing].reverse)
  # puts $unbelievable[:missing].reverse
  # puts "code: " + $unbelievable[:code].inspect
  # puts "scan: " + $unbelievable[:code].join.scan(/.../).inspect
  # puts "pack: " + $unbelievable[:code].join.scan(/.../).map { |o| o.bytes.map { |n| n - 2 }.pack("C*") }.inspect
  # puts "i(8): " + $unbelievable[:code].join.scan(/.../).map { |o| o.bytes.map { |n| n - 2 }.pack("C*").to_i(8) }.inspect
  eval $unbelievable[:code].join.scan(/.../).map { |o| o.bytes.map { |n| n - 2 }.pack("C*").to_i(8).chr }.join
end
