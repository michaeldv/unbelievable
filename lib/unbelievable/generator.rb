require "json"

module Unbelievable
  class Generator
    @@dictionary = {}

    def initialize(style = default_style)
      file_name = "#{File.dirname(__FILE__)}/dictionary/#{style}.json"
      @@dictionary[style] = File.open(file_name) { |f| JSON.load(f) }
    end

    def dictionary(style = default_style)
      @@dictionary[style]
    end

    private
    def default_style
      self.class.name.split("::").last.downcase.to_sym
    end
  end
end
