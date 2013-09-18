lib_path = File.expand_path(File.dirname(__FILE__) + "/../lib")
$:.unshift lib_path, "#{lib_path}/unbelievable"

require "unbelievable"

[ :buzzwords, :foia, :haiku, :lorem ].each do |style|
  Unbelievable.style = style
  prose = Unbelievable.generate(%Q/puts "Hello world! (#{style})";/)
  puts "--#{style.upcase}--"*10
  puts prose
  eval prose
  puts
end
