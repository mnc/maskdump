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
      connect_db
      ActiveRecord::Tasks::DatabaseTasks.structure_dump(@setting.db_setting_hash, options[:dest])
    end

    private

    def connect_db
      ActiveRecord::Base.establish_connection(@setting.db_setting_hash)
    end
  end
end
