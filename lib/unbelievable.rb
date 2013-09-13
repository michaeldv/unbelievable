
src = 'puts "Hello world!"'
chars = src.unpack("C*")
puts chars.inspect
puts sprintf("%03o" * chars.size, *chars)
sizes = sprintf("%03o" * chars.size, *chars).unpack("C*").map{ |n| n - 45 }
puts sizes.inspect
puts '---'
# [4, 9, 3, 4, 9, 8, 4, 9, 7, 4, 9, 6, 3, 7, 3, 3, 7, 5, 4, 4, 3, 4, 7, 8, 4, 8, 7, 4, 8, 7, 4, 8, 10, 3, 7, 3, 4, 9, 10, 4, 8, 10, 4, 9, 5, 4, 8, 7, 4, 7, 7, 3, 7, 4, 3, 7, 5]

$code, $missing = [], []
def method_missing(name, *args)
  # puts "#{name}: #{args}, #{$missing.inspect}"
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
  # puts "code: " + $code.join
  # puts "scan: " + $code.join.scan(/.../).inspect
  # puts "pack: " + $code.join.scan(/.../).map { |o| o.bytes.map { |n| n - 2 }.pack("C*").to_i(8).chr }.join
  eval $code.join.scan(/.../).map { |o| o.bytes.map { |n| n - 2 }.pack("C*").to_i(8).chr }.join
end

Like marvelous sun over
beautiful nameless sea? Marvelous
whisper with beautiful
bamboo. Hot crystal ans

Raw evening along soft warm
sun. Five soaring stunning
eyes. Gracious unusual eyes

Remember sixteen pure gracious
birthdays? Six crystal raw
lips. Wonderful wheelhouse over
peaceful refreshing snow

Wonderful crisp
lips. Tranquil retreat with
awesome unusual
him. Sixteen aged hot mirrors

Peace