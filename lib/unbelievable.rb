

require 'benchmark'

src = 'puts "Hello world!"'
chars = src.unpack("C*")
#puts chars.inspect
sizes = sprintf("%03o" * chars.size, *chars).unpack("C*").map{ |n| n - 45 }
puts sizes.inspect


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


# 2, 7, 1, 2, 7, 6, 2, 7, 5, 2, 7, 4, 1, 5, 1, 1, 5, 3, 2, 2, 1, 2, 5, 6, 2, 6, 5, 2, 6, 5, 2, 6, 8, 1, 5, 1, 2, 7, 8, 2, 6, 8, 2, 7, 3, 2, 6, 5, 2, 5, 5, 1, 5, 2, 1, 5, 3


# d1 = src.unpack("C*").map { |c| c.to_s(7).rjust(3) }.join.tr(" 0123456", "11234567").chars.map(&:to_i)
# puts d1.inspect
# 
# digits = src.unpack("C*").map {|c| c.to_s(7).rjust(3, "0") }.join.chars.map{ |n| n.to_i + 1 }
# puts digits.inspect