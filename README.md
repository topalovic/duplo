Duplo
=====

[![Gem Version](https://badge.fury.io/rb/duplo.svg)](https://rubygems.org/gems/duplo)
[![Build Status](https://travis-ci.org/topalovic/duplo.svg?branch=master)](https://travis-ci.org/topalovic/duplo)

Build nested collections with minimum fuss.

<img src="https://cloud.githubusercontent.com/assets/626128/7639329/545932e6-fa7b-11e4-84b0-a64c9e23c9df.png" width="100">


## Usage

Let's say you like matrices (bear with me), but not rolling them out
by hand or writing loops to populate them. Or say you might need a few
nested hashes to test something real quick in the console, but
generating them can be a drag.

So how about this:

```ruby
require "duplo"
include Duplo

a3a4
# => [[0, 1, 2, 3], [0, 1, 2, 3], [0, 1, 2, 3]]
```

Bam. A 3x4 matrix.

Want it randomized? Just pass it a block to populate the entries:

```ruby
a3a4 { rand -10..10 }
# => [[1, 9, 8, 3], [3, 0, -1, -2], [2, 0, 5, -7]]

a3a4 { rand }
# => [[0.6222777300676433,  0.5613390139342668,  0.37293736375203324, 0.7319666374054961],
#     [0.3798588109025701,  0.33483069318178915, 0.8779112502970073,  0.22476545143154103],
#     [0.37651300630626683, 0.5035024403835663,  0.8237420938739567,  0.7611012983149591]]
```

This works too:

```ruby
Duplo.a3a4
```

so you don't really need to include the module. If you do, don't worry
about monkey patching - the gem works its magic through
`method_missing` so your namespace won't be polluted.

### Entry path

Accessing the entry path is easy peasy:

```ruby
I4 = a4a4 { |i, j| i == j ? 1 : 0  }
# => [[1, 0, 0, 0], [0, 1, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]
```

Have I mentioned that you can nest structures up to an arbitrary
depth?

```ruby
a4a11a3a2 { |path| path.join(":") }
# => [[[["0:0:0:0", "0:0:0:1"], ["0:0:1:0", "0:0:1:1"], ["0:0:2:0", "0:0:2:1"]],
#      [["0:1:0:0", "0:1:0:1"], ["0:1:1:0", "0:1:1:1"], ["0:1:2:0", "0:1:2:1"]],
#       . . .
#      [["3:10:0:0", "3:10:0:1"], ["3:10:1:0", "3:10:1:1"], ["3:10:2:0", "3:10:2:1"]]]]
```

### Other toys

You can use `h` for Hashes, `s` for Sets and mix and match collection
types to your heart's desire:

```ruby
ah2s3 { abc.sample(2).join }
# => [{0=>#<Set: {"kx", "by", "fi"}>, 1=>#<Set: {"uz", "ow", "tx"}>},
#     {0=>#<Set: {"tp", "ch", "ba"}>, 1=>#<Set: {"nu", "mn", "ve"}>},
#     {0=>#<Set: {"nc", "dh", "dc"}>, 1=>#<Set: {"le", "ks", "th"}>},
#     {0=>#<Set: {"ca", "xj", "lm"}>, 1=>#<Set: {"hg", "xg", "rz"}>},
#     {0=>#<Set: {"oq", "vb", "ed"}>, 1=>#<Set: {"gq", "px", "sv"}>}]
```

You can spell it out if you like:

```ruby
Duplo.spell "ah22s0"
# => "5-element Array containing 22-element Hashes containing empty Sets"
```

Note that I've omitted a dim for the root array in the last
example. It defaults to 5, so `as2h` yields the same result as
`a5s2h5`. You can easily change it like this:

```ruby
Duplo.default_size = 3
```

Also, I sneaked in a cute little `abc` method that returns the
alphabet as an array.

### Dynamic dimensions

Want to provide dimensions dynamically? While there's no syntax for
that yet, this should do the trick:

```ruby
m, n = 3, 4
toy = "a#{m}a#{n}"

Duplo.build(toy) { rand }
```


## Installation

Add this line to your application's Gemfile, presumably in the
"development" or "test" group:

```ruby
gem "duplo"
```

or install it yourself as:

```console
$ gem install duplo
```

My personal preference is to drop this in `.pryrc` (or `.irbrc`):


```ruby
require "duplo"
include Duplo
```

and have those handy shortcuts available in every session, `a` and `h`
in particular.


## Testing

To test the gem, clone the repo and run:

```
$ bundle
$ bundle exec rake
```


## License

This gem is released under the [MIT License](http://www.opensource.org/licenses/MIT).
