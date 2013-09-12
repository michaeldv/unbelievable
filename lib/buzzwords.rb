require "./core_ext/array"

class Buzzwords
  DICTIONARY = {
    verb: %w(dig zap fix log use rate book grow hack push sack swap fake sell check
    study gauge build create draft drive morph order scale deploy enable engage
    verify evolve extend manage design target retain deliver embrace empower
    enhance exploit monitor develop approve rebrand utilize automate expedite
    generate incubate leverage maximize monetize optimize redefine reinvent
    aggregate architect benchmark cultivate implement integrate repurpose syndicate
    synergize jumpstart transform facilitate prioritize productize streamline
    synthesize transition),

    plural: %w(ads UIs GUIs hubs slots specs brands users models niches stocks
    actions markets metrics portals schemas systems designs drivers channels
    eyeballs! networks interns services pageviews! analytics paradigms platforms
    customers solutions synergies appliances interfaces milestones),

    singular: %w(GUI LTE XML hub HTML JSON LDAP SaaS beta blog core spec HTML5
    brand focus frame group model access mashup engine matrix! policy portal system
    webinar ability! adapter archive circuit concept! loyalty network pricing!
    process product project! support synergy toolset website Internet Intranet
    alliance analyzer approach business capacity commerce customer database
    encoding! extranet firmware! forecast! function hardware helpdesk workflow
    paradigm protocol software! solution strategy algorithm bandwidth! benchmark
    diversity challenge! emulation framework groupware hierarchy interface
    knowledge migration moderator readiness structure taskforce timeframe workforce
    capability complexity encryption enterprise initiative management middleware
    monitoring moratorium projection throughput mindshare! console),

    adjective: %w(new hot full open meme local solid smart viral global killer
    static robust secure modern mobile backend foreign diverse dynamic focused
    leading offshore organic virtual advanced balanced critical enhanced expanded
    extended frontend granular european holistic holistic magnetic optional
    profound reactive realtime scalable seamless shareable vertical wireless
    automated budgetary digitized downsized countless efficient ergonomic exclusive
    impactful intuitive mandatory networked optimized polarised proactive strategic
    universal versatile visionary worldwide artificial compatible compelling
    customized extensible horizontal innovative integrated persistent standalone
    successful switchable synergized ubiquitous upgradable),

    adverb: %w(oh! yt? plz OMG ASAP also only nvm; more? done? ASAP! FAST! yeah.
    damn! simply further please quickly quietly rapidly swiftly promptly urgently
    carefully discreetly diligently),

    numeral: %w(our their many some several few two three four five six seven eight
    nine ten eleven twelve hundred sixteen thousand thirteen seventeen thousands
    thirteenth eighteenth)
  }

  TEMPLATES = [
    # Sentences with 1 or 2 words.
    { vars: [ :verb ] },
    { vars: [ :verb, :plural ] },
    { vars: [ :verb, :singular ] },

    # Sentences with 3 words.
    { vars: [ :adverb, :verb, :plural ] },
    { vars: [ :adverb, :verb, :singular ] },
    { vars: [ :verb, :numeral, :plural ] },
    { vars: [ :verb, :adjective, :plural ] },
    { vars: [ :verb, :adjective, :singular ] },

    # Sentences with 4 words.
    { vars: [ :adverb, :verb, :adjective, :plural ] },
    { vars: [ :adverb, :verb, :adjective, :singular ] },
    { vars: [ :adverb, :verb, :numeral, :plural ] },
    { vars: [ :verb, :adjective, :adjective, :plural ] },
    { vars: [ :verb, :numeral, :adjective, :plural ] },

    # Sentences with 5 words.
    { vars: [ :adverb, :verb, :numeral, :adjective, :plural ] },
    { vars: [ :verb, :numeral, :adjective, :adjective, :plural ] }
  ]

  def sentence(*words)
    # Pick templates with given number of words.
    templates = TEMPLATES.select { |template| template[:vars].size == words.size }
    return nil if templates.empty?

    sentences = templates.map do |template|
      vars = words.dup
      formatted = template[:vars].map { |var| DICTIONARY[var].pick(vars.shift) }.join(" ")
      formatted << ";" unless formatted.end_with?("!")
      formatted
    end

    sentences.sample
  end

  def paragraph(*words)
    sentences = []

    while words.any? do
      sentences += [ 5, 4 ].shuffle.map do |n|
        found = sentence(*words[0, n]) if words.any?
        words.shift(found.split.size) if found
        found
      end.compact
    end

    sentences.join("\n")
  end
end

puts Buzzwords.new.paragraph(4, 9, 3, 4, 9, 8, 4, 9, 7, 4, 9, 6, 3, 7, 3, 3, 7, 5, 4, 4, 3, 4, 7, 8, 4, 8, 7, 4, 8, 7, 4, 8, 10, 3, 7, 3, 4, 9, 10, 4, 8, 10, 4, 9, 5, 4, 8, 7, 4, 7, 7, 3, 7, 4, 3, 7, 5)
