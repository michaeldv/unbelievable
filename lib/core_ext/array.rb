class Array
  def pick(size)
    word = self.select { |item| item.size == size }.sample
    word ||= "x" * size # Only if we miss the word in the dictionary.
  end
end
