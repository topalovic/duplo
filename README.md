Duplo
=====

[![Gem Version](https://badge.fury.io/rb/duplo.svg)](https://rubygems.org/gems/duplo)
[![Build Status](https://travis-ci.org/topalovic/duplo.svg?branch=master)](https://travis-ci.org/topalovic/duplo)

Generating nested collections with minimum effort.

```
.-===============-.
| ( ) ( ) ( ) ( ) |
| ( ) ( ) ( ) ( ) |
'-----------------' ndt.
```


## Usage

Say you like matrices (bear with me), but not rolling them out by hand
or writing nested loops to populate them. You might need a nested hash
to test something real quick in your console, but generating it can be
a royal PITA.

So how about this:

```ruby
require "duplo"
include Duplo

a3a4
# => [[0, 1, 2, 3], [0, 1, 2, 3], [0, 1, 2, 3]]
```

Bam. A 3x4 matrix.

Want it random? Sure. Pass it a block to populate the entries:

```ruby
a3a4 { rand -5..5 }
# => [[1, 9, 8, 3], [3, 0, -1, -2], [2, 0, 5, -7]]
a3a4 { rand }
# => [[0.6222777300676433,  0.5613390139342668,  0.37293736375203324, 0.7319666374054961],
#     [0.3798588109025701,  0.33483069318178915, 0.8779112502970073,  0.22476545143154103],
#     [0.37651300630626683, 0.5035024403835663,  0.8237420938739567,  0.7611012983149591]]
```

Accessing the current entry path is easy peasy:

```ruby
a3a3a2 { |i,j,k| [i,j,k].join(":") }
# => [[["0:0:0", "0:0:1"], ["0:1:0", "0:1:1"], ["0:2:0", "0:2:1"]],
#     [["1:0:0", "1:0:1"], ["1:1:0", "1:1:1"], ["1:2:0", "1:2:1"]],
#     [["2:0:0", "2:0:1"], ["2:1:0", "2:1:1"], ["2:2:0", "2:2:1"]]]
 ```

Have I mentioned that you can go up to an arbitrary number of
dimensions? Just watch out, it might get sluggish with higher dims due
to the recursive approach under the hood.

So how 'bout them Hashes:

```ruby
h3h2h2 { |path| "I'm a #{path.join}" }
# => {0=>{0=>{0=>"I'm a 000", 1=>"I'm a 001"}, 1=>{0=>"I'm a 010", 1=>"I'm a 011"}},
#     1=>{0=>{0=>"I'm a 100", 1=>"I'm a 101"}, 1=>{0=>"I'm a 110", 1=>"I'm a 111"}},
#     2=>{0=>{0=>"I'm a 200", 1=>"I'm a 201"}, 1=>{0=>"I'm a 210", 1=>"I'm a 211"}}}
```

You can also use `s` for Sets, and mix and match collection types to
your little heart's desire:

```ruby
ah2s3 { abc.sample(2).join }
# => [{0=>#<Set: {"kx", "by", "fi"}>, 1=>#<Set: {"uz", "ow", "tx"}>},
#     {0=>#<Set: {"tp", "ch", "ba"}>, 1=>#<Set: {"nu", "mn", "ve"}>},
#     {0=>#<Set: {"nc", "dh", "dc"}>, 1=>#<Set: {"le", "ks", "th"}>},
#     {0=>#<Set: {"ca", "xj", "lm"}>, 1=>#<Set: {"hg", "xg", "rz"}>},
#     {0=>#<Set: {"oq", "vb", "ed"}>, 1=>#<Set: {"gq", "px", "sv"}>}]
```

You get the picture. If you're *really* bored, you can spell those out
for fun:

```ruby
Duplo.spell "ah2s0"
# => "5-element Array containing 2-element Hashes containing empty Sets"
```

Note that I've omitted a dim for the root array in that last
example. It defaults to 5, so `as2h` means the same thing as
`a5s2h5`. You can easily change the default size like this:

```ruby
Duplo.default_size = 3
```

Also, I sneaked in a cute little `abc` method that returns the
alphabet as an array (as seen in the last example).


## Installation

You know the drill. Add this line to your application's Gemfile
(presumably in the "development" or "test" group):

```ruby
gem "duplo"
```

or install it yourself as:

```console
$ gem install duplo
```

It's not exactly necessary to include the module, so you can work like
this:

```ruby
Duplo.a2a2
```

If you do include it, don't worry about monkey patching - the gem
works its magic by utilizing `method_missing`, so there should be no
name clashes.

My personal preference is to drop this in `.pryrc` (or `.irbrc`):


```ruby
begin
  require "duplo"
  include Duplo
rescue LoadError
end
```

and have those handy shortcuts available in every session, `a` and `h`
in particular.


## Testing

To test the gem, clone the repo and run:

```
$ bundle
$ bundle exec rake
```


## Contributing

1. [Fork it](https://github.com/topalovic/duplo/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new pull request


## License

This gem is released under the [MIT License](http://www.opensource.org/licenses/MIT).
