require "./core_ext/array"

class Haiku
  DICTIONARY = {
    singular: %w(you her him sea sky ice tea air sun dove seed bell rock wave face
    sand snow tree hand wind lake skin fire monk moon life rain light heart apple
    color river frost leave stone night creek smoke sword blood grass world amber
    cloud pebble temple flower shadow breeze scroll summer bamboo candle spring
    canyon mirror meadow someone journey evening whisper origami morning rainbow
    diamond crescent nighfall sunshine wildness mountain waterfall butterfly
    moonlight breadcrumb marionette wheelhouse ),

    plural: %w(lips eyes monks birds rocks seeds wings ideas faces waves bells hands
    monks trees clouds petals stones leaves apples pebbles dreams hearts wounds
    colors meadow mirrors candles flowers shadows breaths temples gardens diamonds
    blankets droplets whispers birthdays mountains waterfalls scarecrows jellybeans),

    adjective: %w(new hot old bare aged pure soft wild warm tiny sharp clear white
    fresh quiet sweet crisp sleepy tender lovely smooth simple fallen pretty gentle
    bright silent perfect lonely crystal awesome amazing restful handsome gracious
    peaceful elegant secluded merciful nameless stunning tranquil marvelous
    beautiful startling wonderful refreshing delightful weightless),

    numeral: %w(many two three four five six seven eight nine ten eleven twelve
    sixteen hundreds thirteen thousands seventeen thirteenth eighteenth),

    single: %w(Yes Yum Wow Yeah Aha! Agh! Yay! Oops Peace Awesome Awesome! Really?
    Amazing Amazing! Beautiful Beautiful! Wonderful Wonderful!),

    conjunction: %w(and and and with with with among above over besides)
  }

  QUESTIONS = {
    "Are you enjoying" => [ 3, 3, 8 ],
    "Have you seen"    => [ 4, 3, 4 ],
    "Not enjoying"     => [ 3, 8 ],
    "Forgot about"     => [ 6, 5 ],
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

  CONJUNCTION = lambda { |words| DICTIONARY[:conjunction].map(&:size).uniq.include? words[2] }
  PLURAL2 = lambda { |words| words.size == 2 && words[1] > 3 }
  PLURAL3 = lambda { |words| words.size == 3 && words[2] > 3 }

  TEMPLATES = [
    { vars: [ :single ] },
    { vars: [ :single, :single ] },
    { vars: [ :numeral, :plural ], when: PLURAL2 },
    { vars: [ :adjective, :plural ], when: PLURAL2 },
    { vars: [ :adjective, :singular ] },

    { vars: [ :adjective, :adjective, :plural ], when: PLURAL3 },
    { vars: [ :adjective, :adjective, :singular ] },
    { vars: [ :numeral, :adjective, :plural ], when: PLURAL3 },

    { vars: [ :adjective, :singular, :conjunction, :singular ], when: CONJUNCTION },

    { vars: [ :adjective, :singular, :conjunction, :adjective, :singular ], when: CONJUNCTION },

    { vars: [ :adjective, :singular, :conjunction, :adjective, :adjective, :singular ], when: CONJUNCTION }
  ]

  def question(*words)
    return {} if words.size < 5
    etalon = words.join
    Hash[*QUESTIONS.select { |_,v| etalon.start_with?(v.join) }.to_a.sample ]
  end

  def sentence(*words)
    q = question(*words)
    templates = TEMPLATES.select do |t|
      ok = t[:when] ? t[:when].call(words) : true
      ok && t[:vars].size == words.size - q.values.size
    end
    return nil if templates.empty?

    sentences = templates.map do |template|
      vars = words.dup
      formatted = template[:vars].map { |var| DICTIONARY[var].pick(vars.shift) }.join(" ")
      formatted = "#{q.keys[0]} #{formatted}?" if q.any? # TODO: extra ? char
      formatted += "." unless formatted =~ /[\.\?!]$/
      formatted.capitalize
    end

    # sentences.sort_by(&:size).first # Pick the longest sentence.
    sentences.sample
  end

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
