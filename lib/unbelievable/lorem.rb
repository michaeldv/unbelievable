module Unbelievable
  class Lorem < Generator

    def paragraph(*words)
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

puts "-LOREM-" * 10
puts Unbelievable::Lorem.new.paragraph(4, 9, 3, 4, 9, 8, 4, 9, 7, 4, 9, 6, 3, 7, 3, 3, 7, 5, 4, 4, 3, 4, 7, 8, 4, 8, 7, 4, 8, 7, 4, 8, 10, 3, 7, 3, 4, 9, 10, 4, 8, 10, 4, 9, 5, 4, 8, 7, 4, 7, 7, 3, 7, 4, 3, 7, 5)
