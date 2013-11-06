lib_path = File.expand_path(File.dirname(__FILE__) + "/../lib")
$:.unshift lib_path, "#{lib_path}/unbelievable"

require "unbelievable"

code = <<-EOS
  def fib(n)
    n < 2 ? n : fib(n - 1) + fib(n - 2)
  end
  puts (1..10).map { |i| fib(i) }.inspect;
EOS

stories = [ :buzzwords, :foia, :haiku, :lorem ].map do |style|
  Unbelievable.style = style
  story = Unbelievable.generate(code)
  puts " UNBELIEVABLE #{style.upcase} ".center(72, "=") << "\n#{story}\n\n"
  story
end

stories.each { |story| eval story }
