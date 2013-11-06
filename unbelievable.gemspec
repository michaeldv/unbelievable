# Copyright (c) 2013 Michael Dvorkin
#
# Unbelievable is freely distributable under the terms of MIT license.
# See LICENSE file or http://www.opensource.org/licenses/mit-license.php
#------------------------------------------------------------------------------
require File.dirname(__FILE__) + "/lib/unbelievable/version"

Gem::Specification.new do |s|
  s.name          = "unbelievable"
  s.version       = Unbelievable.version
# s.platform      = Gem::Platform::RUBY
  s.authors       = "Michael Dvorkin"
  s.date          = Time.now.strftime("%Y-%m-%d")
  s.email         = "mike@dvorkin.net"
  s.license       = "MIT"
  s.homepage      = "http://github.com/michaeldv/unbelievable"
  s.summary       = ""
  s.description   = ""

  s.files         = Dir["[A-Z]*[^~]"] + Dir["lib/**/*.rb"] + [".gitignore"]
  s.test_files    = Dir["test/*"]
  s.executables   = []
  s.require_paths = ["lib"]
  s.required_ruby_version = ">= 1.9.3"
end
