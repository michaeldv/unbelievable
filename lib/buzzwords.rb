VERBS = %w(dig zap grow sell build drive morph scale deploy enable engage
evolve extend manage target deliver embrace empower enhance exploit monitor
rebrand utilize automate expedite generate incubate leverage maximize
monetize optimize redefine reinvent aggregate architect benchmark cultivate
implement integrate repurpose syndicate synergize transform visualize
facilitate productize streamline synthesize transition)

PLURALS = %w(UIs hubs slots specs users models niches actions markets metrics
portals schemas systems channels eyeballs! networks services pageviews!
paradigms platforms solutions synergies appliances interfaces)

SINGULARS = %w(GUI hub core spec user array focus frame group model access
engine matrix! policy portal system ability! adapter archive circuit concept
loyalty network pricing process product project support synergy toolset
website Internet Intranet alliance analyzer approach business capacity
commerce customer database encoding extranet firmware forecast! function
hardware helpdesk paradigm protocol software! solution strategy algorithm
bandwidth! benchmark challenge! emulation framework groupware hierarchy
interface knowledge migration moderator readiness structure taskforce
timeframe workforce capability complexity! encryption! enterprise initiative
management middleware monitoring moratorium projection throughput! mindshare!
console)

ADJECTIVES = %w(B2B B2C rich sexy local smart viral global killer phased
robust secure backend diverse dynamic focused leading organic virtual
advanced balanced critical enhanced expanded extended frontend granular
holistic magnetic optional profound reactive realtime scalable seamless
shareable vertical wireless automated budgetary digitized downsized efficient
ergonomic exclusive impactful intuitive mandatory networked optimized
polarised proactive strategic universal versatile visionary worldwide
artificial compatible compelling customized extensible horizontal innovative
integrated persistent standalone successful switchable synergized ubiquitous
upgradable)

ADVERBS = %w(oh! more? done? also simply just further please quickly quietly
rapidly swiftly promptly urgently carefully discreetly diligently)

NUMERALS = %w(our their many some several two three four five six seven eight
nine ten eleven twelve thirteen seventeen thirteenth eighteenth)

TEMPLATES = [
  { vars: [ :verbs ] },
  { vars: [ :verbs, :plurals ] },
  { vars: [ :verbs, :singulars ] },

  { vars: [ :adverbs, :verbs, :plurals ] }, #
  { vars: [ :adverbs, :verbs, :singulars ] }, #
  { vars: [ :verbs, :numerals, :plurals ] },
  { vars: [ :verbs, :adjectives, :plurals ] },
  { vars: [ :verbs, :adjectives, :singulars ] },

  { vars: [ :adverbs, :verbs, :adjectives, :plurals ] }, #
  { vars: [ :adverbs, :verbs, :adjectives, :singulars ] }, #
  { vars: [ :adverbs, :verbs, :numerals, :plurals ] }, #
  { vars: [ :verbs, :adjectives, :adjectives, :plurals ] },
  { vars: [ :verbs, :numerals, :adjectives, :plurals ] },

  { vars: [ :adverbs, :verbs, :numerals, :adjectives, :plurals ] },
  { vars: [ :verbs, :numerals, :adjectives, :adjectives, :plurals ] }
]

def sentence(*words)
  templates = TEMPLATES.select do |t|
    ok = t[:only] ? t[:only].call(words) : true
    ok && t[:vars].size == words.size
  end

  sentences = templates.map do |template|
    str = template[:vars].map { |var| Kernel.const_get(var.to_s.upcase).sample }.join(" ")
    str << ";" unless str.end_with?("!")
    str
  end

  sentences.sort_by(&:size).first
end

def paragraph(*words)
  sentences = []
  loop do
    # attempts = [6,6,6,6,5,5,5,4,4,3,2,1].shuffle.map do |n|
    attempts = [5,4].map do |n|
      found = sentence(*words[0,n])
      words.shift(found.split.size) if found
      found
    end.compact
    break if attempts.empty?
    sentences += attempts
  end
  puts sentences.join("\n")
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