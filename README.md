# TidyLogger

[![Build Status](https://travis-ci.org/kenn/tidy_logger.png)](https://travis-ci.org/kenn/tidy_logger)

Better API for Ruby’s stdlib Logger.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tidy_logger'
```

## Usage

Ruby's stdlib `Logger` is great. It gives you so many features that you don't want to reinvent.

But, don't you think the default format is verbose and ugly? I do!

```ruby
require 'logger'

logger = Logger.new(STDOUT)
logger.info 'hello world!'      # => "I, [2013-03-21T19:46:31.703381 #27585]  INFO -- : hello world!\n"
```

Here comes TidyLogger. It's a thin API wrapper for and a subclass of the stdlib Logger. It's 100% compatible and you can use TidyLogger and Logger interchangeably - the only method that's added to Logger is `config`. When you call it, all the shapeshifting happens.

Supported config options are `:plain`, `:time`, `:title`, `:time_and_level` (chosen when no argument is given), `:ltsv` ([Labeled Tab-Separated Values](http://ltsv.org)) and lambdas.

```ruby
require 'tidy_logger'

logger = TidyLogger.new(STDOUT)
logger.info 'hello world!'      # => "I, [2013-03-21T19:46:31.703381 #27585]  INFO -- : hello world!\n"

logger.config
logger.info 'hello'             # => "[2013-03-21T21:19:54]  INFO : hello"

logger.config(:plain)
logger.info 'hello'             # => "hello"

logger.config(:time)
logger.info 'hello'             # => "[2013-03-21T21:19:10] hello"

logger.config(title: 'note')
logger.info 'hello'             # => "[note] hello"

logger.config(:ltsv)
logger.info fizz: 1, buzz: 2    # => "fizz:1\tbuzz:2"

logger.config lambda{|_,_,_,msg| "///do crazy stuff/// #{msg}\n" }
logger.info 'hello'             # => "///do crazy stuff/// hello"
```

The lambda takes `(severity, time, progname, msg)` as arguments.

### Bonus

The `config` method returns self, so that you can tidy up in method chain.

```ruby
logger = TidyLogger.new(STDOUT).config(:plain)      # One-liner initialization

logger.config(:plain).info 'hello'                  # One-off config switch
```

It's just a Logger, you can use every feature that comes with Logger.

```ruby
logger = TidyLogger.new('my.log', 'daily').config
logger = TidyLogger.new('my.log', 7, 10.megabytes).config

logger.debug { "Total users: #{User.count}" }       # Do not run the heavy query on production
```
