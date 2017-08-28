require 'mozaic/bulk_insert/mysql'
require 'mozaic/bulk_insert/postgresql'
require 'mozaic/bulk_insert/sqlite'

module Mozaic
  module BulkInsert
    class << self
      def generate(table_name, records, columns, setting)
        klass(setting).new(table_name, records, columns).generate
      end

      private

      def klass(setting)
        case
        when setting.mysql?
          Mysql
        when setting.postgresql?
          Postgresql
        when setting.sqlite?
          Sqlite
        else
          Mysql
        end
      end
    end
  end
end
