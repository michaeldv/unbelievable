module Unbelievable
  class Buzzwords < Generator
    TEMPLATES = [
      [ :verb                                                ],
      [ :verb,   :plural                                     ],
      [ :verb,   :singular                                   ],
      [ :adverb, :verb,      :plural                         ],
      [ :adverb, :verb,      :singular                       ],
    # [ :verb,   :numeral,   :plural                         ],
    # [ :verb,   :adjective, :plural                         ],
      [ :verb,   :adjective, :singular                       ],
      [ :adverb, :verb,      :adjective, :plural             ],
      [ :adverb, :verb,      :adjective, :singular           ],
    # [ :adverb, :verb,      :numeral,   :plural             ],
      [ :verb,   :numeral,   :adjective, :plural             ],
      [ :adverb, :verb,      :numeral,   :adjective, :plural ]
    ]

    def sentence(words)
      # Pick templates with given number of words.
      templates = TEMPLATES.select { |template| template.size == words.size }

      sentences = templates.map do |template|
        vars = words.dup
        formatted = template.map { |var| dictionary[var.to_s].pick(vars.shift) }
        formatted.first.capitalize! unless formatted.first =~ /^[A-Z]|[\?!]$/
        formatted.join(" ")
      end

      sentences.sample
    end

    def paragraph(*words)
      sentences = []

      while words.any? do
        sentences += [ 5, 4 ].shuffle.map do |n|
          found = sentence(words[0, n]) if words.any?
          words.shift(found.split.size) if found
          found
        end
      end

      sentences.compact.each_with_index.map { |todo, i| "#{i+1}. #{todo}" }.join("\n")
    end
  end
end

# puts "-BUZZ-" * 10
# puts Unbelievable::Buzzwords.new.paragraph(4, 9, 3, 4, 9, 8, 4, 9, 7, 4, 9, 6, 3, 7, 3, 3, 7, 5, 4, 4, 3, 4, 7, 8, 4, 8, 7, 4, 8, 7, 4, 8, 10, 3, 7, 3, 4, 9, 10, 4, 8, 10, 4, 9, 5, 4, 8, 7, 4, 7, 7, 3, 7, 4, 3, 7, 5)

