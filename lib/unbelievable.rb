$:.unshift("./")
require "unbelievable/core_ext/array"
require "unbelievable/generator"
require "unbelievable/buzzwords"
require "unbelievable/haiku"
require "unbelievable/lorem"


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

1. omg! jumpstart big core
2. Carefully reinvent many ergonomic actions
3. nvm! architect twelve hot markets
4. Log ten diverse slots
5. Only book all bold metrics
6. Urgently grow balanced synergy
7. Book thousand virtual hubs
8. Promptly prioritize six dynamic UIs
9. ooh! benchmark thirteenth full channels
10. Prioritize many polarised slots
11. Only expedite backend GUIs
12. Quietly enhance all backend labs
13. yt? approve users
