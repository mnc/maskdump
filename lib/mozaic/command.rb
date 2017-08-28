require 'thor'
require 'yaml'
require 'active_record'

module Mozaic
  class Command < Thor
    desc "dump", "dump"
    def dump(yaml)
      @setting = Setting.new(yaml, options)
    end
  end
end
