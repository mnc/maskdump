require 'thor'
require 'yaml'
require 'active_record'

module Maskdump
  class Command < Thor

    class_option :database, type: :string, aliases: "-d", banner: 'database'
    class_option :user,     type: :array,  aliases: "-u", banner: 'user'
    class_option :password, type: :string, aliases: "-p", banner: 'password'
    class_option :output,   type: :string, aliases: "-o", banner: 'output', required: true

    desc "dump", "dump"
    def dump(yaml)
      @setting = Setting.new(yaml, options)
      connect_db
      ActiveRecord::Tasks::DatabaseTasks.structure_dump(@setting.db_setting_hash, options[:output])
      @setting.tables.each do |table_setting|
        table = Table.new(table_setting[:name])
        next if table.records.blank?
        masked_records = Mask.new(table.records, table_setting[:columns]).mask
        query = BulkInsert.generate(table.name, masked_records, table.columns, @setting)
        File.open(options[:output], 'a') do |f|
          f.puts "\n"
          f.puts query
          f.puts "\n"
        end
      end
    end

    private

    def connect_db
      ActiveRecord::Base.establish_connection(@setting.db_setting_hash)
    end
  end
end
