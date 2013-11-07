# Copyright (c) 2013 Michael Dvorkin
#
# Unbelievable is freely distributable under the terms of MIT license.
# See LICENSE file or http://www.opensource.org/licenses/mit-license.php

require "json"

module Unbelievable
  class Generator
    @@dictionary = {}

    def initialize(style = default_style)
      file_name = "#{File.dirname(__FILE__)}/dictionary/#{style}.json"
      @@dictionary[style] ||= File.open(file_name) { |f| JSON.load(f) }
    end

    protected
    def dictionary(style = default_style)
      @@dictionary[style]
    end

    private
    def default_style
      self.class.name.split("::").last.downcase.to_sym
    end
  end
end
