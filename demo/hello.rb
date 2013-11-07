lib_path = File.expand_path(File.dirname(__FILE__) + "/../lib")
$:.unshift lib_path, "#{lib_path}/unbelievable"

require "unbelievable"

stories = [ :todo, :secret, :lorem , :haiku].map do |style|
  Unbelievable.style = style
  story = Unbelievable.generate(%Q/puts "Hello world! (#{style})";/)
  puts " UNBELIEVABLE #{style.upcase} ".center(72, "=") << "\n#{story}\n\n"
  story
end

stories.each { |story| eval story }
