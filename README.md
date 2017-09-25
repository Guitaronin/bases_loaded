# BasesLoaded

This gem provides a simple way to configure multiple database connection pools in a rails application. I previously had success with [octopus](https://github.com/thiagopradi/octopus), but then it wasn't compatible with newer versions of rails. Then I tried [secondbase](https://github.com/customink/secondbase), which has a really elegant implementation, but only seems to support a second connection pool. BasesLoaded is inspired by secondbase, but with a focus on unlimited connection pools.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bases_loaded'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bases_loaded

## Usage

To get started with your new update your database.yml to include a `bases_loaded` config key. Below that, nest keys for each of your databases.

```yaml
# Default configurations:
development:
  adapter: sqlserver
  database: myapp_development
test:
  adapter: sqlserver
  database: myapp_test
# BasesLoaded configurations:
bases_loaded:
  my_cool_database:
    development:
      adapter: mysql
      database: myapp_development
    test:
      adapter: mysql
      database: myapp_test
  my_other_cooler_database:
    development:
      adapter: mysql
      database: myapp_development
```

Then include and initialize in your model, like so:

```ruby
class MyModel < ActiveRecord::Base
  include BasesLoaded
  bases_loaded_init 'my_cool_database'
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Guitaronin/bases_loaded.
