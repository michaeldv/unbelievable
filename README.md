### Unbelievable ###

Unbelievable is a Ruby gem that lets you write Ruby code in plain language.
Seriously ;-) Here's a quick "Hello, world!" example written in lorem ispum:

```
$ cat lorem.rb
require "unbelievable"

Odio imperdiet sem nibh dignissim placerat ante phasellus vivamus arcu
dignissim. Luctus leo dapibus vel sit pretium netus duis diam nec ante
cubilia. Lobortis ante pulvinar varius? Amet sagittis varius? Ante
sagittis. Vestibulum sit aliquam est nisi elementum vestibulum diam
gravida! Adipiscing erat hendrerit dolor elit gravida! Iaculis cras
quisque. Varius? Mis iaculis quis sed rhoncus morbi sit adipiscing
libero

$ ruby lorem.rb
Hello, world!
```

The gem comes with the story generator that converts existing Ruby code to
a random story of your choice. The lorem ipsum example above might be
produced as follows:

```ruby
require "unbelievable"

Unbelievable.style = :lorem                         # Optional story style.
puts Unbelievable.generate('puts "Hello, world!"')  # Ruby code to convert.
```

Out of the box the gem supports five story styles: `:haiku`, `:lorem`, `:todo`,
`:secret`, and `:random` which is the default style. Check out the `/demo`
directory for more usage examples.

### Bug Reports ###

Bug reports will not be accepted unless you provide a fix. Fork the project
on Github, commit your fix, and send commit URL (*do not* send pull requests).

### Specials Thanks ###

The unbelievable gem was inspired by Yusuke Endoh, one of the greatest Ruby
hackers of all time.

### License ###

Copyright (c) 2013 Michael Dvorkin

`%w(mike dvorkin.net) * "@" || "twitter.com/mid" || "http://www.dvorkin.net"`

Released at the RubyConf 2013 in Miami. Further released under the MIT license.
See LICENSE file for details.
