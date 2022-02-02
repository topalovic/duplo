Duplo
=====

[![Gem Version](https://badge.fury.io/rb/duplo.svg)](https://rubygems.org/gems/duplo)

A tiny Ruby DSL for generating collections.

<img src="https://cloud.githubusercontent.com/assets/626128/7639329/545932e6-fa7b-11e4-84b0-a64c9e23c9df.png" width="100">


## Usage

Let's say you like matrices (bear with me) but not rolling them out by
hand. Or say you need to generate some data samples quickly in the
console but writing nested loops is not really your idea of fun.

So how about this:

```ruby
require "duplo"
include Duplo

a4a8
#=> [[0, 1, 2, 3, 4, 5, 6, 7],
#    [0, 1, 2, 3, 4, 5, 6, 7],
#    [0, 1, 2, 3, 4, 5, 6, 7],
#    [0, 1, 2, 3, 4, 5, 6, 7]]
```

Bam. A 4x8 matrix.

Want it randomized? Just pass it a block to populate the entries:

```ruby
a4a8 { rand 10 }
#=> [[5, 1, 2, 7, 8, 9, 6, 1],
#    [7, 6, 6, 0, 7, 1, 0, 8],
#    [9, 3, 8, 7, 6, 4, 4, 5],
#    [3, 0, 9, 0, 7, 3, 8, 9]]
```

This works too:

```ruby
Duplo.a4a8
```

so including the module is optional. The gem works its magic through
`method_missing` so it won't stomp on existing names either way.


### Entry path

Populating the entries is easy peasy. Here, have an identity matrix:

```ruby
I5 = a5a5 { |i, j| i == j ? 1 : 0 }
#=> [[1, 0, 0, 0, 0],
#    [0, 1, 0, 0, 0],
#    [0, 0, 1, 0, 0],
#    [0, 0, 0, 1, 0],
#    [0, 0, 0, 0, 1]
```

If plain old matrices bore you, you can do simple vectors:

```ruby
a10 { |i| i ** 2 }
#=> [0, 1, 4, 9, 16, 25, 36, 49, 64, 81]
```

or arbitrary tensors:

```ruby
a4a11a2a3 { |path| path.join(":") }
#=> [[[["0:0:0:0", "0:0:0:1", "0:0:0:2"],
#      ["0:0:1:0", "0:0:1:1", "0:0:1:2"]],
#      . . .
#      ["3:10:1:0", "3:10:1:1", "3:10:1:2"]]]]
```

The last example also shows how to use the full entry path without
destructuring.


### Other toys

In addition to `a`rrays, you can build `h`ashes and `s`ets, and mix
and match collection types to your heart's desire:

```ruby
sa2h3 { rand 100 }
#=> #<Set: {[{0=>11, 1=>47, 2=>48}, {0=>3,  1=>71, 2=>57}],
#           [{0=>97, 1=>9,  2=>43}, {0=>90, 1=>30, 2=>62}],
#           [{0=>87, 1=>56, 2=>23}, {0=>24, 1=>16, 2=>63}],
#           [{0=>6,  1=>12, 2=>57}, {0=>44, 1=>3,  2=>74}],
#           [{0=>52, 1=>92, 2=>12}, {0=>93, 1=>32, 2=>1}]}>
```

Let's spell that out:

```ruby
Duplo.spell "sa2h3"
#=> "5-element Set containing 2-element Arrays containing 3-element Hashes"
```

Note that I've omitted size for the root collection there. It defaults
to 5, so `aaa` yields the same result as `a5a5a5`. Set your preferred
default like this:

```ruby
Duplo.default_size = 10
```


### Dynamic dimensions

If you want to supply dimensions dynamically, this should do the trick:

```ruby
m, n = 3, 4
toy = "a#{m}a#{n}"

Duplo.build(toy) { rand }
```


## Installation

Add this line to your application's Gemfile:

```ruby
gem "duplo"
```

or install it yourself as:

```sh
$ gem install duplo
```

My personal preference is to drop this into `.irbrc` (or `.pryrc`):

```ruby
require "duplo"
include Duplo
```

and have all those handy shortcuts available in every session.



## Testing

To test the gem, clone the repo and run:

```
$ bundle && bundle exec rake
```


## License

This gem is released under the [MIT License](http://www.opensource.org/licenses/MIT).
