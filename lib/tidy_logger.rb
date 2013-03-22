require 'logger'

class TidyLogger < ::Logger
  def initialize(*args)
    super
    @formatter = Formatter.new
  end

  def config(options = :time_and_level)
    case options
    when Symbol
      options = { type: options }
    when Hash
      options[:type] = :time_and_level  if options[:type].nil?
      options[:type] = :title           if options[:title]
    when Proc
      options = { type: options }
    else
      raise Error, "invalid options: #{options.inspect}"
    end

    self.formatter.type             = options[:type]
    self.level                      = options[:level] || Logger::INFO
    self.formatter.datetime_format  = options[:datetime_format] || '%Y-%m-%dT%H:%M:%S'
    self.formatter.title            = options[:title]
    self
  end

  class Formatter < ::Logger::Formatter
    attr_accessor :type, :title

    def call(severity, time, progname, msg)
      case @type
      when Proc
        instance_exec(severity, time, progname, msg, &@type)
      when :plain
        "#{stringify(msg)}\n"
      when :title
        "[#{@title}] #{stringify(msg)}\n"
      when :time
        "[#{format_datetime(time)}] #{stringify(msg)}\n"
      when :time_and_level
        "[%s] %5s : %s\n" % [format_datetime(time), severity, stringify(msg)]
      when :ltsv
        raise Error, "ltsv logger only takes Hash" unless msg.is_a?(Hash)
        msg.map{|k,v| "#{k}:#{v}" }.join("\t") << "\n"
      else
        # default stdlib logger format
        "%s, [%s#%d] %5s -- %s: %s\n" % [severity[0..0], format_datetime(time), $$, severity, progname, msg2str(msg)]
      end
    end

    def stringify(msg)
      String === msg ? msg : msg.inspect
    end
  end

  Error = Class.new(StandardError)
end
