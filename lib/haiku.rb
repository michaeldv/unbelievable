require "./core_ext/array"

class Haiku
  DICTIONARY = {
    singular: %w(you her him sea sky ice tea air sun dove seed bell rock wave
    face cave leaf sand snow tree hand wind lake skin fire monk moon life rain
    light heart apple petal puppy smile color river frost leave stone night creek
    smoke sword blood grass world amber cloud pebble temple flower shadow breeze
    scroll summer bamboo kitten candle spring canyon mirror meadow someone
    whisper journey retreat evening whisper origami morning rainbow diamond
    crescent nighfall sunshine wildness mountain waterfall butterfly moonlight
    breadcrumb marionette wheelhouse),

    plural: %w(ova ans lips eyes monks birds rocks seeds wings ideas faces waves
    bells hands monks trees clouds petals stones leaves apples pebbles dreams
    hearts petals wounds colors meadows mirrors candles flowers whispers shadows
    breaths temples gardens diamonds blankets droplets whispers birthdays
    mountains waterfalls scarecrows jellybeans),

    adjective: %w(raw hot old wet cold fine bare aged pure soft wild warm tiny
    sharp clear white fresh quiet sweet crisp sleepy tender lovely joyful smooth
    simple fallen pretty gentle bright silent perfect lonely crystal unusual
    awesome amazing sacred fading restful handsome gracious peaceful elegant
    secluded merciful nameless stunning painful soaring tranquil marvelous
    beautiful startling wonderful refreshing delightful weightless),

    numeral: %w(two many some three four five six seven eight nine ten eleven
    twelve sixteen hundreds thirteen thousands seventeen thirteenth eighteenth),

    single: %w(Yes Yum Wow Aha Agh Yay Yeah Oops Peace Enjoy Really Awesome
    Amazing Beautiful Wonderful Standstill),

    conjunction: %w(yet with with near over along among above around besides
    without whenever wherever although therefore underneath)
  }

  QUESTIONS = {
    "Are you enjoying" => [ 3, 3, 8 ],
    "Have you seen"    => [ 4, 3, 4 ],
    "Not enjoying"     => [ 3, 8 ],
    "Forgot about"     => [ 6, 5 ],
    "Dream about"      => [ 5, 5 ],
    "Remember"         => [ 8 ],
    "Cherish"          => [ 7 ],
    "Recall"           => [ 6 ],
    "Enjoy"            => [ 5 ],
    "Adore"            => [ 5 ],
    "Like"             => [ 4 ],
    "Love"             => [ 4 ],
    "Miss"             => [ 4 ],
    "See"              => [ 3 ]
  }

  TEMPLATES = [
    [ :single                                                                 ],
    [ :numeral,   :plural                                                     ],
    [ :adjective, :plural                                                     ],
    [ :adjective, :singular                                                   ],
    [ :adjective, :adjective, :plural                                         ],
    [ :adjective, :adjective, :singular                                       ],
    [ :numeral,   :adjective, :plural                                         ],
    [ :numeral,   :adjective, :adjective,   :plural                           ],
    [ :adjective, :singular,  :conjunction, :adjective, :singular             ],
    [ :adjective, :singular,  :conjunction, :adjective, :adjective, :singular ]
  ]

  def paragraph(*words)
    sentences = []

    while words.any? do
      sentences += [ 7, 6, 5, 4, 3 ].shuffle.map do |n|
        found = sentence(*words[0, n]) if words.any?
        words.shift(found.split.size) if found
        found
      end.compact
    end

    each_haiku(sentences) do |haiku|
      reformat(haiku)
    end
  end

  private

  def pick_question(words)
    return {} if words.size < 5 || words[-1] < 4

    list = words.join
    Hash[*QUESTIONS.select { |_,v| list.start_with?(v.join) }.to_a.sample ]
  end

  def select_templates(words, size = 0)
    limit = words.size - size
    TEMPLATES.select { |template| template.size == limit }
  end

  def sentence(*words)
    question = pick_question(words)
    templates = select_templates(words, question.any? ? question.values.first.size : 0)

    sentences = templates.map do |template|
      vars, terms = words.dup, []

      if question.any?
        next if template.size != vars.size - question.values.first.size
        terms = question.keys.first.split # Start with question words.
        vars.shift(terms.size)            # Reduce variables since we've added some words already.
        vars[-1] -= 1                     # Make the last word shorter since we're appending "?".
      end

      terms.concat template.map { |var| DICTIONARY[var].pick(vars.shift) }
      formatted = terms.join(" ")
      formatted << "?" if question.any?
      formatted << "." unless formatted =~ /[\.\?!]$/
      formatted.capitalize
    end.compact

    sentences.sort_by(&:size).first # Pick the longest sentence.
    # sentences.sample
  end

  def each_haiku(sentences)
    sentences.each_slice(3).map do |slice|
      yield slice.join(" ").sub(/\.\s*$/, "") # No trailing period.
    end
  end

  def reformat(haiku)
    words, breaks, last_break = haiku.split, [], 0

    # Add newlines to all the words that end with period.
    words.each_with_index do |word, i|
      if word =~ /\./
        words[i] = "\n#{word}"
        breaks << i
      end
    end
    breaks << words.size

    # Go over the list of words again and add newlines in
    # between long sentences.
    words.each_with_index do |word, i|
      if i > 0 && i - last_break == 4 && breaks.first - i > 1
        words[i] = "\n#{word}"
      end

      last_break = i if words[i].start_with?("\n")
      breaks.shift if i == breaks.first
    end

    words.join(" ") << "\n\n"
  end
end

puts Haiku.new.paragraph(4, 9, 3, 4, 9, 8, 4, 9, 7, 4, 9, 6, 3, 7, 3, 3, 7, 5, 4, 4, 3, 4, 7, 8, 4, 8, 7, 4, 8, 7, 4, 8, 10, 3, 7, 3, 4, 9, 10, 4, 8, 10, 4, 9, 5, 4, 8, 7, 4, 7, 7, 3, 7, 4, 3, 7, 5)
