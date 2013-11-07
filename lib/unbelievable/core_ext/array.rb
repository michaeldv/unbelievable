# Copyright (c) 2013 Michael Dvorkin
#
# Unbelievable is freely distributable under the terms of MIT license.
# See LICENSE file or http://www.opensource.org/licenses/mit-license.php

class Array
  def pick(size)
    word = self.select { |item| item.size == size }.sample
    word ||= "x" * size # Only if we miss the word in the dictionary.
  end
end
