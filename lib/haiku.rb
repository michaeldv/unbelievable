SINGULARS = %w(air sun seed bell face sand snow tree hand wind lake skin fire
monk moon life rain heart color river frost leave music stone night creek
grass world cloud temple flower shadow breeze scroll summer bamboo spring
morning someone journey evening whisper nighfall birthday mountain waterfall
butterfly jellybean moonlight breadcrumb)

PLURALS = %w(lips eyes birds seeds wings ideas faces bells hands monks trees
clouds petals stones leaves dreams hearts wounds colors flowers shadows
breaths temples gardens blankets droplets whispers birthdays mountains
waterfalls scarecrows jellybeans)

ADJECTIVES = %w(new hot old bare pure soft wild warm sharp clear quiet sweet
sleepy tender fallen pretty gentle bright silent lonely awesome amazing
gracious peaceful nameless beautiful wonderful refreshing)

NUMERALS = %w(many two three four five six seven eight nine ten eleven twelve
thirteen seventeen thirteenth eighteenth)

QUESTIONS = {
  "Are you enjoying" => [ 3, 3, 8 ],
  "Have you seen"    => [ 4, 3, 4 ],
  "Not enjoying"     => [ 3, 8 ],
  "Forgot about"     => [ 6, 5 ],
  "Remember"         => [ 8 ],
  "Cherish"          => [ 6 ],
  "Again"            => [ 5 ],
  "Lost"             => [ 4 ],
  "See"              => [ 3 ]
}

OK = %w(Yes Yum Wow Aha! Agh! Yay! Oops Peace Awesome Awesome! Really?
Amazing Amazing! Beautiful Beautiful! Wonderful Wonderful!)

CONJ = %w(and and and with with with yet among over besides)

conjunction = lambda { |words| CONJ.map(&:size).include? words[2] }
TEMPLATES = [
  { vars: [ :ok ] },
  { vars: [ :ok, :ok ] },
  { vars: [ :numerals, :plurals ] },
  { vars: [ :adjectives, :plurals ] },
  { vars: [ :adjectives, :singulars ] },

  { vars: [ :adjectives, :adjectives, :plurals ] },
  { vars: [ :adjectives, :adjectives, :singulars ] },
  { vars: [ :numerals, :adjectives, :plurals ] },

  { vars: [ :adjectives, :plurals, :conj, :plurals ], only: conjunction },
  { vars: [ :adjectives, :singulars, :conj, :plurals ], only: conjunction },

  { vars: [ :adjectives, :plurals, :conj, :adjectives, :plurals ], only: conjunction },
  { vars: [ :adjectives, :singulars, :conj, :adjectives, :plurals ], only: conjunction },
  { vars: [ :adjectives, :plurals, :conj, :numerals, :plurals ], only: conjunction },

  { vars: [ :adjectives, :plurals, :conj, :numerals, :adjectives, :plurals ], only: conjunction },
  { vars: [ :adjectives, :singulars, :conj, :numerals, :adjectives, :plurals ], only: conjunction }
]

def question(*words)
  return {} if words.size < 5
  etalon = words.join
  Hash[*QUESTIONS.find { |_,v| etalon.start_with?(v.join) }]
end

def sentence(*words)
  q = question(*words)
  templates = TEMPLATES.select do |t|
    ok = t[:only] ? t[:only].call(words) : true
    ok && t[:vars].size == words.size - q.values.size
  end

  sentences = templates.map do |template|
    str = template[:vars].map { |var| Kernel.const_get(var.to_s.upcase).sample }.join(" ")
    str = "#{q.keys[0]} #{str}?" if q.any? # TODO: extra ? char
    str = str[0].capitalize + str[1..-1]
    str += "." unless str =~ /[\.\?!]$/
    str
  end

  sentences.sort_by(&:size).first
end

def paragraph(*words)
  sentences = []
  loop do
    # attempts = [6,6,6,6,5,5,5,4,4,3,2,1].shuffle.map do |n|
    attempts = [7,6,5,4].map do |n|
      found = sentence(*words[0,n])
      words.shift(found.split.size) if found
      found
    end.compact
    break if attempts.empty?
    sentences += attempts
  end

  poem = each_haiku(sentences) do |haiku|
    reformat(haiku)
  end
  puts poem

  puts; puts; puts words.inspect
end

def each_haiku(sentences)
  sentences.each_slice(3).map do |slice|
    yield slice.join(" ").sub(/\.\s*$/, "") # No trailing period.
  end
end

def reformat(haiku)
  with_breaks = haiku.split.slice_before(/\.$/).map do |slice|
    slice[5] = "\n#{slice[5]}" if slice.size > 6
    slice[0] = "\n#{slice[0]}" if slice[0].end_with?(".")
    slice
  end
  with_breaks.join(" ") << "\n\n"
end

paragraph(4, 9, 3, 4, 9, 8, 4, 9, 7, 4, 9, 6, 3, 7, 3, 3, 7, 5, 4, 4, 3, 4, 7, 8, 4, 8, 7, 4, 8, 7, 4, 8, 10, 3, 7, 3, 4, 9, 10, 4, 8, 10, 4, 9, 5, 4, 8, 7, 4, 7, 7, 3, 7, 4, 3, 7, 5)
