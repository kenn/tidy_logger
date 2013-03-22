# TidyLogger

[![Build Status](https://travis-ci.org/kenn/tidy_logger.png)](https://travis-ci.org/kenn/tidy_logger)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tidy_logger'
```

## Usage

Ruby's stdlib `Logger` is great. It gives you so many features that you don't want to reinvent.

```ruby
require 'logger'

logger = Logger.new(STDOUT)
logger.info 'hello world!'      # => "I, [2013-03-21T19:46:31.703381 #27585]  INFO -- : hello world!\n"
```

But, don't you think the default format is ugly? I do!

Here comes TidyLogger. It is a subclass of and 100% compatible with the stdlib Logger. You can use it and Logger interchangeably.

```ruby
require 'tidy_logger'

logger = TidyLogger.new(STDOUT)
logger.info 'hello world!'      # => "I, [2013-03-21T19:46:31.703381 #27585]  INFO -- : hello world!\n"
```

The only method that's added to Logger is `config` - when you call it, all the shapeshifting happens.

```ruby
logger = TidyLogger.new(STDOUT)
logger.config
logger.info 'hello'             # => "[2013-03-21T21:19:54]  INFO : hello"
logger.config(:plain)
logger.info 'hello'             # => "hello"
logger.config(:time)
logger.info 'hello'             # => "[2013-03-21T21:19:10] hello"
logger.config(title: 'note')
logger.info 'hello'             # => "[note] hello"
```

TidyLogger also supports lambda and [LTSV](http://ltsv.org)!

```ruby
logger.config lambda{|_,_,_,msg| "///do crazy stuff/// #{msg2str(msg)}\n" }
logger.info 'hello'             # => "///do crazy stuff/// hello"

logger.config(:ltsv)
logger.info fizz: 1, buzz: 2    # => "fizz:1\tbuzz:2"
```
