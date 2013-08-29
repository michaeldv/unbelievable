VERBS = %w(dig zap grow sell build drive morph scale deploy enable engage evolve extend manage target
 deliver embrace empower enhance exploit monitor rebrand utilize automate expedite generate incubate
leverage maximize monetize optimize redefine reinvent aggregate architect benchmark cultivate implement
integrate repurpose syndicate synergize transform visualize facilitate productize streamline synthesize
transition

digged zapped grew sold built drove morphed scaled deployed enabled engaged evolved extended managed targeted
 delivered embraced empowered enhanced exploited monitored rebranded utilized automated expedited generated incubated
leveraged maximized monetized optimized redefined reinvented aggregated architected benchmarked cultivated implemented
integrated repurposed syndicated synergized transformed visualized facilitated productized streamlined synthesized
transitioned)

ACTIONS = %w(zaps grows diggs sells builds drives morphs scales deploys enables engages evolves extends manages targets
 delivers embraces empowers enhances exploits monitors rebrands utilizes automates expedites generates incubates
leverages maximizes monetizes optimizes redefines reinvents aggregates architects benchmarks cultivates implements
integrates repurposes syndicates synergizes transforms visualizes facilitates productizes streamlines synthesizes
transitions

digged zapped grew sold built drove morphed scaled deployed enabled engaged evolved extended managed targeted
 delivered embraced empowered enhanced exploited monitored rebranded utilized automated expedited generated incubated
leveraged maximized monetized optimized redefined reinvented aggregated architected benchmarked cultivated implemented
integrated repurposed syndicated synergized transformed visualized facilitated productized streamlined synthesized
transitioned)

PLURALS = %w(UIs bugs hubs slots specs users models niches actions markets metrics portals schemas systems
channels eyeballs networks services pageviews! paradigms platforms solutions synergies appliances
interfaces)

SINGULARS = %w(GUI bug hub core spec user array focus frame group model access engine matrix policy portal
system ability! adapter archive circuit concept loyalty network pricing process product project support synergy
toolset website Internet Intranet alliance analyzer approach business capacity commerce customer database
encoding extranet firmware forecast! function hardware helpdesk paradigm protocol software! solution strategy
algorithm bandwidth! benchmark challenge! emulation framework groupware hierarchy interface knowledge migration
moderator readiness structure taskforce timeframe workforce capability complexity! encryption! enterprise
initiative management middleware monitoring moratorium projection throughput! mindshare! console)

ADJECTIVES = %w(B2B B2C rich sexy local smart viral global killer phased robust secure backend diverse
dynamic focused leading organic virtual advanced balanced critical enhanced expanded extended frontend granular
holistic magnetic optional profound reactive realtime scalable seamless shareable vertical wireless automated
budgetary digitized downsized efficient ergonomic exclusive impactful intuitive mandatory networked optimized
polarised proactive strategic universal versatile visionary worldwide artificial compatible compelling
customized extensible horizontal innovative integrated persistent standalone successful switchable synergized
ubiquitous upgradable)

ADVERBS = %w(often always calmly happily quickly quietly swiftly actually joyfully promptly secretly silently
urgently anxiously carefully furiously sometimes cautiously)

NAMES = %w(Ava Eli Eva Ian Mia Zoe Adam Alex Anna Aria Ella Emma Evan Jace Jack John Jose Juan Lana Leah
Levi Liam Lily Lucy Luis Luke Maya Noah Owen Ryan Zoey Aaron Aiden Alexa Angel Avery Ayden Bella Blake Brody
Caleb Chase Chloe David Diana Dylan Ellie Emily Ethan Faith Gavin Grace Henry Isaac Jacob James Jason Jaxon
Julia Kayla Kevin Khloe Kylie Laura Layla Logan Lucas Lydia Mason Molly Naomi Nolan Piper Riley Ryder Sarah
Sofia Tyler Wyatt Adrian Alexis Alyssa Amelia Andrea Andrew Ariana Ashley Aubree Aubrey Audrey Austin Autumn
Bailey Bryson Camila Carlos Carson Carter Claire Colton Connor Cooper Damian Daniel Easton Elijah Evelyn
Gianna Hailey Hannah Harper Hudson Hunter Isaiah Jayden Jordan Joseph Joshua Josiah Julian Justin Kayden
Kaylee Landon Lauren London Morgan Nathan Nevaeh Oliver Olivia Parker Peyton Reagan Robert Samuel Skylar
Sophia Sophie Stella Sydney Taylor Thomas Violet Xavier Aaliyah Abigail Addison Allison Anthony Arianna
Bentley Brandon Brayden Brianna Cameron Charles Dominic Gabriel Grayson Jackson Jasmine Jocelyn Kennedy
Lillian Madelyn Madison Makayla Matthew Melanie Michael Natalie Trinity Tristan William Zachary Benjamin
Brooklyn Caroline Isabella Jeremiah Jonathan Kimberly Madeline Nicholas Samantha Savannah Scarlett Serenity
Victoria Alexander Alexandra Annabelle Charlotte Christian Elizabeth Gabriella Katherine Mackenzie Nathaniel
Sebastian)

CONJUNCTIONS = %w(and with)
INTRO = %w(our their many only)
PEOPLE = %w(engineers managers marketers executives students analysts bloggers investors interns)
NUMERALS = %w(our their only many some several two three four five six seven eight nine ten eleven twelve thirteen seventeen thirteenth eighteenth)

QUESTIONS = {
  "Has anyone figured why" => [ 3, 6, 7, 3 ],
  "Does anybody know why"  => [ 4, 7, 4, 3 ],
  "Not sure why"           => [ 3, 4, 3 ],
  "Why the heck"           => [ 3, 3, 4 ],
  "Why"                    => [ 3 ]
}

OK = %w(OK?)

conjunction = lambda { |words| CONJUNCTIONS.map(&:size).include?(words[1]) }
people = lambda { |words| INTRO.map(&:size).include?(words[0]) && PEOPLE.map(&:size).include?(words[1]) }
action = lambda { |words| ACTIONS.map(&:size).uniq.include?(words[1]) }
TEMPLATES = [
  { vars: [ :ok ], only: lambda { |words| words[0] == 3 } },
  { vars: [ :verbs, :plurals ] },
  { vars: [ :numerals, :plurals ] },
  { vars: [ :verbs, :adjectives, :plurals ] },
  { vars: [ :numerals, :adjectives, :plurals ] },
  { vars: [ :verbs, :adjectives, :adjectives, :plurals ] },
  { vars: [ :numerals, :adjectives, :adjectives, :plurals ] },
  { vars: [ :verbs, :numerals, :adjectives, :adjectives, :plurals ] },

  { vars: [ :names, :actions, :adjectives, :singulars ], only: action },
  { vars: [ :names, :actions, :adjectives, :plurals ], only: action },
# { vars: [ :names, :adverbs, :actions, :adjectives, :singulars ], only: action },
# { vars: [ :names, :adverbs, :actions, :adjectives, :plurals ], only: action },
  { vars: [ :names, :actions, :numerals, :adjectives, :plurals ], only: action },

  { vars: [ :names, :conjunctions, :names, :verbs, :adjectives, :singulars ], only: conjunction },
  { vars: [ :names, :conjunctions, :names, :verbs, :adjectives, :plurals ], only: conjunction },
  { vars: [ :names, :conjunctions, :names, :adverbs, :verbs, :adjectives, :singulars ], only: conjunction },
  { vars: [ :names, :conjunctions, :names, :adverbs, :verbs, :adjectives, :plurals ], only: conjunction },
  { vars: [ :names, :conjunctions, :names, :verbs, :numerals, :adjectives, :plurals ], only: conjunction },

  { vars: [ :intro, :people, :verbs, :adjectives, :singulars ], only: people },
  { vars: [ :intro, :people, :verbs, :adjectives, :plurals ], only: people },
  { vars: [ :intro, :people, :adverbs, :verbs, :adjectives, :singulars ], only: people },
  { vars: [ :intro, :people, :adverbs, :verbs, :adjectives, :plurals ], only: people },
  { vars: [ :intro, :people, :verbs, :numerals, :adjectives, :plurals ], only: people }
]

def question(*words)
  return {} if words.size < 6
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

# 10.times do
#   puts sentence(5,6,7,8)
#   puts sentence(5,6,7,8,9)
#   puts sentence(5,3,5,6,7,8)
#   puts sentence(5,4,5,6,7,8,9)
#   puts sentence(3,8,5,6,7,8)
#   puts sentence(3,4,3,8,5,6,7,8)
# end

# 5.times { puts "#{names.sample} #{verbs.sample}s #{adjectives.sample} #{singulars.sample}" }
# puts '---'
# 5.times { puts "#{names.sample} #{verbs.sample}s #{adjectives.sample} #{plurals.sample}" }
# puts '---'
# 5.times { puts "#{names.sample} #{adverbs.sample} #{verbs.sample}s #{adjectives.sample} #{plurals.sample}" }
# puts '---'
# 50.times { puts "#{names.sample} #{verbs.sample}s #{numerals.sample} #{adjectives.sample} #{plurals.sample}" }
# puts '---'
# 5.times { puts "#{names.sample} and #{names.sample} #{verbs.sample} #{adjectives.sample} #{singulars.sample}" }
# puts '---'
# 5.times { puts "#{names.sample} with #{names.sample} #{verbs.sample} #{adjectives.sample} #{singulars.sample}" }
# puts '---'
# 5.times { puts "#{intro.sample} #{names.sample} #{verbs.sample}s #{adjectives.sample} #{plurals.sample}?" }
# 
# 
# puts (verbs + names + adverbs + adjectives + singulars + plurals + verbs).select {|x| x.size == 3 }.inspect