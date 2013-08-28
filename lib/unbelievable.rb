

require 'benchmark'

src = 'puts "Hello world!"'
chars = src.unpack("C*")
#puts chars.inspect
sizes = sprintf("%03o" * chars.size, *chars).unpack("C*").map{ |n| n - 45 }
puts sizes.inspect

# [4, 9, 3, 4, 9, 8, 4, 9, 7, 4, 9, 6, 3, 7, 3, 3, 7, 5, 4, 4, 3, 4, 7, 8, 4, 8, 7, 4, 8, 7, 4, 8, 10, 3, 7, 3, 4, 9, 10, 4, 8, 10, 4, 9, 5, 4, 8, 7, 4, 7, 7, 3, 7, 4, 3, 7, 5]

exit

Benchmark.bmbm do |x|
  # x.report { 10_000.times { src.unpack("C*").map {|c| c.to_s(8).rjust(3) }.join.tr(" 0123456", "11234567").chars.map(&:to_i) }}
  # x.report { 10_000.times { src.unpack("C*").map {|c| c.to_s(8).rjust(3, "0") }.join.chars.map{ |n| n.to_i + 1 } }}
  # x.report { 10_000.times { src.unpack("C*").map {|c| c.to_s(8).rjust(3, "0").chars.to_a }.flatten.map{ |n| n.to_i + 1 } }}

  # x.report do
  #   10_000.times do
  #     chars = src.unpack("C*")
  #     sprintf("%03o" * chars.size, *chars).tr("01234567", "12345678").chars.map(&:to_i)
  #   end
  # end
  # 
  # x.report do
  #   10_000.times do
  #     chars = src.unpack("C*")
  #     sprintf("%03o" * chars.size, *chars).chars.map{ |n| n.to_i + 1 }
  #   end
  # end
  # 
  # x.report do
  #   10_000.times do
  #     chars = src.unpack("C*")
  #     sprintf("%03o" * chars.size, *chars).chars.map{ |n| n.to_i + 1 }
  #   end
  # end
  # 
  x.report do
    10_000.times do
      chars = src.unpack("C*")
      sprintf("%03d" * chars.size, *chars).unpack("C*").map{ |n| n - 42 }
    end
  end
end



# d1 = src.unpack("C*").map { |c| c.to_s(7).rjust(3) }.join.tr(" 0123456", "11234567").chars.map(&:to_i)
# puts d1.inspect
# 
# digits = src.unpack("C*").map {|c| c.to_s(7).rjust(3, "0") }.join.chars.map{ |n| n.to_i + 1 }
# puts digits.inspect