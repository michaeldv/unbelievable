module Unbelievable
  class Buzzwords
    DICTIONARY = {

      verb: %w(buy dig zap fix log use win rate book grow hack push sack swap fake
      sell check study gauge build create draft drive morph order scale deploy
      enable engage verify evolve extend manage design target retain deliver embrace
      empower enhance exploit monitor develop approve rebrand utilize automate
      expedite generate incubate leverage maximize monetize optimize redesign
      reinvent aggregate architect benchmark cultivate implement integrate repurpose
      syndicate synergize jumpstart transform facilitate prioritize productize
      streamline synthesize transition),

      plural: %w(ads UIs GUIs fabs hubs labs slots specs brands users models niches
      stocks actions markets metrics portals systems designs drivers channels
      eyeballs! networks services pageviews! analytics paradigms platforms customers
      solutions synergies appliances interfaces milestones),

      singular: %w(GUI LTE XML fab hub lab HTML JSON LDAP SaaS beta blog core spec
      HTML5 brand focus frame group model access mashup engine matrix! policy portal
      system webinar ability! adapter archive circuit concept! loyalty network
      pricing! process product project! support synergy toolset website Internet
      Intranet alliance analyzer approach business capacity commerce customer
      database encoding! extranet firmware! forecast! function hardware helpdesk
      workflow paradigm protocol software! solution strategy algorithm bandwidth!
      benchmark diversity challenge! emulation framework groupware hierarchy
      interface knowledge migration moderator readiness structure taskforce
      timeframe workforce capability complexity encryption enterprise initiative
      management middleware monitoring moratorium projection throughput mindshare!
      console),

      adjective: %w(big raw hot full bold meme local solid smart viral global killer
      static robust secure modern mobile backend diverse dynamic focused leading
      offshore organic virtual advanced balanced critical enhanced expanded extended
      frontend granular european holistic holistic magnetic optional profound
      reactive realtime scalable seamless shareable vertical wireless automated
      budgetary digitized downsized efficient ergonomic exclusive impactful
      intuitive mandatory networked optimized polarised proactive strategic
      universal versatile visionary worldwide artificial compatible compelling
      customized extensible horizontal innovative integrated persistent standalone
      successful switchable synergized ubiquitous upgradable),

      adverb: %w(oh! yt? plz nvm OMG ASAP only nvm! ooh! omg! more? done? ASAP!
      FAST! yeah! damn! simply further please quickly quietly rapidly promptly
      urgently carefully discreetly diligently),

      numeral: %w(ten all few six four five many some three dozen twelve several
      hundred sixteen thousand thirteen seventeen countless thousands thirteenth
      eighteenth)
    }

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
        formatted = template.map { |var| DICTIONARY[var].pick(vars.shift) }
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

puts "-BUZZ-" * 10
puts Unbelievable::Buzzwords.new.paragraph(4, 9, 3, 4, 9, 8, 4, 9, 7, 4, 9, 6, 3, 7, 3, 3, 7, 5, 4, 4, 3, 4, 7, 8, 4, 8, 7, 4, 8, 7, 4, 8, 10, 3, 7, 3, 4, 9, 10, 4, 8, 10, 4, 9, 5, 4, 8, 7, 4, 7, 7, 3, 7, 4, 3, 7, 5)
