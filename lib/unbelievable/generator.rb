require "json"

module Unbelievable
  class Generator
    @@dictionary = {}

    def initialize(style = default_style)
      file_name = "#{File.dirname(__FILE__)}/dictionary/#{style}.json"
      # puts "loading #{file_name} (#{style.inspect})"
      @@dictionary[style] ||= File.open(file_name) { |f| JSON.load(f) }
    end

    protected
    def dictionary(style = default_style)
      # puts "@@dictionary: #{style} => #{@@dictionary[style].to_a.count}"
      @@dictionary[style]
    end

    private
    def default_style
      self.class.name.split("::").last.downcase.to_sym
    end
  end
end
