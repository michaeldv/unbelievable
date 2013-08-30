class Array
  def pick(size)
    self.select { |item| item.size == size }.sample
  end
end


# line = ["Cherish", "gentle", "sky", "besides", "old", "hot", "journey?", "Miss", "pure", "skin", "and", "aged", "crystal", "wildness?", "Remember", "tranquil", "morning", "over", "wildness?"]
# puts line.join(" ")
# 
# br = line.each_slice(5).each_with_index.map do |s, i|
#   if i > 0
#     puts s.inspect
#     s[0] = "\n#{s[0]}" if s.size > 2
#   end
#   s
# end
# 
# puts br.join(" ")
