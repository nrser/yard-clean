Yard::Clean by NRSER
==============================================================================

Yeah this just adds a `yard clean` command to remove the db files.

Sometimes `yard server --reload` just doesn't cut it... generated HTML doesn't
update, or ends up in a mixed state of old and new. This seems especially
prevalent when using plugins.

In these cases, my easy answer is to whack the database directory (defaults to
`.yardoc/`), causing the YARD server to rebuild the database on the next page
load.

Yeah, this is basically `rm -rf ./.yardoc`, but I get sick of typing it, and
scared that I'll fat-finger it and lose some uncommitted code.

So, this could just be a one-liner shell script, except when someone changes
the database directory with `--db FILE`, and then I still need to distribute it
somehow, so this gem seems almost reasonable.

Enjoy!


Installation
------------------------------------------------------------------------------

Add this line to your application's Gemfile:

```ruby
gem 'yard-clean'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install yard-clean

If you're running on a recent YARD, you also need to enable the plugin.

Add this to your `.yardopts`:

    --plugin yard-clean


Usage
------------------------------------------------------------------------------

    $ yard clean


License
------------------------------------------------------------------------------

The gem is available as open source under the terms of the [MIT
License](https://opensource.org/licenses/MIT).
