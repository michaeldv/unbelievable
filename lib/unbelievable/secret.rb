# Copyright (c) 2013 Michael Dvorkin
#
# Unbelievable is freely distributable under the terms of MIT license.
# See LICENSE file or http://www.opensource.org/licenses/mit-license.php

module Unbelievable
  class Secret < Generator

    def initialize(style = default_style)
      super :todo
      @todo ||= begin
        todo = dictionary(:todo)["numeral"].concat(dictionary(:todo)["singular"])
        todo.reject { |word| word.end_with?("!") }
      end
    end

    def paragraph(*words)
      terms = words.map { |size| @todo.pick(size) }
      stash = wrap_text(terms.join(" "))
      stash.gsub(/(\w+)/x) { rand(42) > 2 ? "_" * $1.size : $1 }
    end

    private

    def wrap_text(text, edge = 70)
      text.gsub(/(.{1,#{edge}})(?:\s+|$)|(.{1,#{edge}})/, "\\1\\2\n") # Wrap at whatever the edge column is.
          .gsub(/(\n\w+)(\s[a-z])/x) { $1 << %w(. ; .).sample << $2 } # Add punctiation after the first word on each line.
          .gsub(/[\.\?!]\s[a-z]/) { |match| match.upcase }            # Capitalize words after punctiation signs.
    end
  end
end
