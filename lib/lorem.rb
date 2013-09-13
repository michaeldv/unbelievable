require "./core_ext/array"

class Lorem
  WORDS = %w(
    nam sit sed est non dui nec vel leo sem hac mis duis nibh quis arcu erat ante odio nunc
    enim orci! quam eget nisi elit urna? amet nisl cras diam eros vitae morbi justo risus
    netus ipsum lacus donec fusce angue nulla lorem augue felis magna etiam neque velit
    dolor fames porta purus proin metus massa ligula luctus ornare nullam cursus tellus
    mollis aenean tortor mattis tempus dictum libero auctor tempor lectus rutrum enatis
    primis! platea sapien varius? turpis mauris congue semper curae? euismod integer! aliquet
    sodales dapibus feugiat lacinia egestas blandit cubilia posuere laoreet aliquam pretium
    viverra iaculis rhoncus vivamus quisque gravida! commodo placerat faucibus accumsan
    lobortis volutpat bibendum pharetra facilisi interdum suscipit pulvinar sagittis
    senectus maecenas vehicula molestie dictumst ultrices habitant praesent eleifend
    pretitor ultricies dignissim curabitur phasellus porttitor imperdiet vulputate
    habitasse convallis tristique venenatis tincidunt malesuada consequat fringilla
    facilisis fermentum elementum hendrerit adipiscing vestibulum consectetur ullamcorper
    suspendisse scelerisque condimentum sollicitudin pellentesque
  )

  def paragraph(*words)
    terms = words.map { |size| WORDS.pick(size) }
    wrap_text terms.join(" ").capitalize
  end

  private

  def wrap_text(text, edge = 70)
    text.gsub(/(.{1,#{edge}})(?:\s+|$)|(.{1,#{edge}})/, "\\1\\2\n") # Wrap at whatever the edge column is.
        .gsub(/(\n\w+)(\s[a-z])/x) { $1 << %w(. ; .).sample << $2 } # Add punctiation after the first word on each line.
        .gsub(/[\.\?!]\s[a-z]/) { |match| match.upcase }            # Capitalize words after punctiation signs.
  end
end

puts Lorem.new.paragraph(4, 9, 3, 4, 9, 8, 4, 9, 7, 4, 9, 6, 3, 7, 3, 3, 7, 5, 4, 4, 3, 4, 7, 8, 4, 8, 7, 4, 8, 7, 4, 8, 10, 3, 7, 3, 4, 9, 10, 4, 8, 10, 4, 9, 5, 4, 8, 7, 4, 7, 7, 3, 7, 4, 3, 7, 5)
