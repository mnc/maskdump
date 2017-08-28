require 'thor'
require 'yaml'
require 'active_record'

module Mozaic
  class Command < Thor
    option :d
    option :u
    option :p
    option :dest, required: true

    desc "dump", "dump"
    def dump(yaml)
      @setting = Setting.new(yaml, options)
    end
  end
end
