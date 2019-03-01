module Maskdump
  module BulkInsert
    class Mysql
      def initialize(table_name, records, columns)
        @table_name = table_name
        @records = records
        @columns = columns
      end

      def generate
        "INSERT INTO #{@table_name} (#{@columns.join(", ")}) VALUES #{value_clause};"
      end

      private

      def value_clause
        @records.map do |record|
          "(#{quote(record).join(", ")})"
        end.join(", ")
      end

      def quote(record)
        record.values.map{ |value| "'#{value}'" }
      end
    end
  end
end
