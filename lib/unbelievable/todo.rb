# Copyright (c) 2013 Michael Dvorkin
#
# Unbelievable is freely distributable under the terms of MIT license.
# See LICENSE file or http://www.opensource.org/licenses/mit-license.php

module Unbelievable
  class Todo < Generator
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
