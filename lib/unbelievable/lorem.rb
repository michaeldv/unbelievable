# Copyright (c) 2013 Michael Dvorkin
#
# Unbelievable is freely distributable under the terms of MIT license.
# See LICENSE file or http://www.opensource.org/licenses/mit-license.php

module Unbelievable
  class Lorem < Generator

    def story(words)
      terms = words.map { |size| dictionary.pick(size) }
      wrap_text terms.join(" ").capitalize
    end

    private

    def wrap_text(text, edge = 70)
      text.gsub(/(.{1,#{edge}})(?:\s+|$)|(.{1,#{edge}})/, "\\1\\2\n") # Wrap at whatever the edge column is.
          .gsub(/(\n\w+)(\s[a-z])/x) { $1 << %w(. ; .).sample << $2 } # Add punctiation after the first word on each line.
          .gsub(/[\.\?!]\s[a-z]/) { |match| match.upcase }            # Capitalize words after punctiation signs.
    end
  end
end
