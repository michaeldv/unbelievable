### Unbelievable ###

Unbelievable is a Ruby gem that lets you write Ruby code in plain language.
Seriously ;-) Here's a quick "Hello, RubyConf!" haiku example:

```
$ cat haiku.rb
require "unbelievable"

Wild startling
sky. Rain therefore peaceful
mind. Startling journey over
wonderful clouds

See elegant him yet unusual
clear sky? Have you seen
painful handsome ova? Remember
journey near gracious dreams?

Miss merciful marionette yet
secluded pebble? Raw crystal
air. Dove along crisp gems

Fantastic crescent with
awesome clear
leaf. Unexpected wave over old
canyon. Warm handsome waterfalls

Eyes whenever beautiful
lips. Elegant butterfly yet
restful fine
orb. Rock among big gems

Fresh her besides crisp
him. Delightful dreams

$ ruby haiku.rb
Hello, RubyConf!
```

The gem comes with the story generator that converts existing Ruby code to
a random story of your choice. The haiku above might be produced as follows:

```ruby
require "unbelievable"

Unbelievable.style = :haiku                           # Optional story style.
puts 'require "unbelievable"'                         # Require the gem.
puts Unbelievable.generate('puts "Hello, RubyConf!"') # Make the story.
```

Out of the box the gem supports five story styles: `:haiku`, `:lorem`, `:todo`,
`:secret`, and `:random` which is the default style. Check out the `/demo`
directory for more usage examples.

### Disclaimer ###

In case you find an unbelievable bug that affects your production system consider
backporting your unbelievable stories to Ruby.

### Specials Thanks ###

The unbelievable gem was inspired by Yusuke Endoh, one of the greatest Ruby
hackers of all time.

### License ###

Copyright (c) 2013 Michael Dvorkin

`%w(mike dvorkin.net) * "@" || "twitter.com/mid" || "http://www.dvorkin.net"`

Released at the RubyConf 2013 in Miami. Further released under the MIT license.
See LICENSE file for details.
