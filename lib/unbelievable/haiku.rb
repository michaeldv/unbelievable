# Copyright (c) 2013 Michael Dvorkin
#
# Unbelievable is freely distributable under the terms of MIT license.
# See LICENSE file or http://www.opensource.org/licenses/mit-license.php

module Unbelievable
  class Haiku < Generator
    TEMPLATES = [
      [ :single                                                                   ],
      [ :numeral,   :plural                                                       ],
      [ :adjective, :plural                                                       ],
      [ :adjective, :singular                                                     ],
      [ :adjective, :adjective,   :plural                                         ],
      [ :adjective, :adjective,   :singular                                       ],
      [ :numeral,   :adjective,   :plural                                         ],
      [ :singular,  :conjunction, :plural                                         ],
      [ :singular,  :conjunction, :adjective,   :plural                           ],
    # [ :numeral,   :adjective,   :adjective,   :plural                           ],
      [ :adjective, :singular,    :conjunction, :adjective, :singular             ],
      [ :adjective, :singular,    :conjunction, :adjective, :adjective, :singular ]
    ]

    QUESTIONS = [ %w(Are you enjoying), %w(Have you seen), %w(Not enjoying),
    %w(Forgot about), %w(Dream about), %w(Remember), %w(Cherish), %w(Recall),
    %w(Enjoy), %w(Adore), %w(Like), %w(Love), %w(Miss), %w(See), ]

    def paragraph(*words)
      sentences = select_sentences(words)
      each_haiku(sentences) do |haiku|
        reformat(haiku)
      end.join
    end

    private

    def select_sentences(words)
      sentences = []

      while words.any? do
        sentences += (3..7).to_a.shuffle.map do |n|
          found = sentence(words[0, n]) if words.any?
          words.shift(found.split.size) if found
          found
        end
      end

      sentences.compact
    end

    def pick_question(words)
      return [] if words.size < 5 || words[-1] < 4

      list = words.join
      Array(QUESTIONS.select { |question| list.start_with?(question.map(&:size).join) }.sample)
    end

    def select_templates(words, size = 0)
      limit = words.size - size
      TEMPLATES.select { |template| template.size == limit }
    end

    def sentence(words)
      question = pick_question(words)
      templates = select_templates(words, question.size)

      sentences = templates.map do |template|
        vars, terms = words.dup, []

        if question.any?
          next if template.size != vars.size - question.size
          terms = question        # Start with question words.
          vars.shift(terms.size)  # Reduce variables since we've added some words already.
          vars[-1] -= 1           # Make the last word shorter since we're appending "?".
        end

        terms.concat(template.map { |var| dictionary[var.to_s].pick(vars.shift) }).join(" ")
      end.compact

      if sentences.any?
        best = sentences.sort_by(&:size).first # Pick the longest sentence. # sentences.sample
        best << "?" if question.any?
        best << "." unless best =~ /[\.\?!]$/
        best.capitalize
      end
    end

    def each_haiku(sentences)
      sentences.each_slice(3).map do |slice|
        yield slice.join(" ").sub(/\.\s*$/, "") # No trailing period.
      end
    end

    def reformat(haiku)
      haiku.gsub(/\s(\w+\.)/, "\n\\1")                              # Words ending with period must start on new line.
           .gsub(/(.{1,#{30}})(?:\s+|$)|(.{1,#{30}})/, "\\1\\2\n")  # Reformat paragraph.
           .gsub(/\n(\w+\n)(\w+\.|$)/, " \\1\\2")                   # Move orphaned words to previous line.
           .concat("\n")
    end
  end
end
