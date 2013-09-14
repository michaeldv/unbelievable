require "./core_ext/array"

class Haiku
  DICTIONARY = {
    singular: %w(you her him sea sky ice tea air orb sun zen dove seed bell rock
    wave face cave leaf sand snow tree hand wind lake skin fire monk moon life
    rain light heart apple petal puppy smile color river frost leave stone night
    creek smoke sword blood grass world amber cloud pebble temple flower shadow
    breeze scroll summer bamboo kitten candle spring canyon mirror meadow someone
    whisper journey retreat evening whisper origami morning rainbow diamond
    crescent nighfall sunshine wildness mountain waterfall butterfly moonlight
    breadcrumb marionette wheelhouse),

    plural: %w(ova ans lips eyes jars gems eggs orbs monks birds rocks seeds
    wings ideas faces waves bells hands monks trees clouds petals stones leaves
    apples pebbles dreams hearts petals wounds colors meadows mirrors candles
    flowers whispers shadows breaths temples gardens diamonds blankets droplets
    whispers birthdays mountains waterfalls scarecrows jellybeans),

    adjective: %w(raw hot old wet big cold fine bare aged pure soft wild warm
    tiny sharp clear white fresh quiet sweet crisp sleepy tender lovely joyful
    smooth simple fallen pretty gentle bright silent perfect lonely crystal
    unusual awesome amazing sacred fading restful handsome gracious peaceful
    elegant secluded merciful nameless stunning painful soaring enormous
    tranquil marvelous beautiful startling wonderful fantastic refreshing
    delightful weightless surprising unexpected),

    numeral: %w(two many some three four five six seven eight nine ten eleven
    twelve sixteen hundreds thirteen thousands seventeen thirteenth eighteenth),

    single: %w(Yes Yum Wow Aha Agh Yay Yeah Oops Peace Enjoy Really Awesome
    Amazing Beautiful Wonderful Standstill),

    conjunction: %w(yet with with near over along among above around besides
    without whenever wherever although therefore underneath)
  }

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
    end
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

      terms.concat(template.map { |var| DICTIONARY[var].pick(vars.shift) }).join(" ")
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

puts Haiku.new.paragraph(4, 9, 3, 4, 9, 8, 4, 9, 7, 4, 9, 6, 3, 7, 3, 3, 7, 5, 4, 4, 3, 4, 7, 8, 4, 8, 7, 4, 8, 7, 4, 8, 10, 3, 7, 3, 4, 9, 10, 4, 8, 10, 4, 9, 5, 4, 8, 7, 4, 7, 7, 3, 7, 4, 3, 7, 5)
