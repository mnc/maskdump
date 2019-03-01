module Maskdump
  module Mask
    class Blackout
      BLACKOUT_CHAR = "#"

      def initialize(records, column_name)
        @records = records
        @column_name = column_name
        @counter = 0
      end

      def mask
        @records.each do |record|
          record[@column_name] = process(record[@column_name])
          @counter += 1
        end
      end

      private

      def process(record)
        return record unless record.is_a?(String)
        record.each_char.map{ BLACKOUT_CHAR }.join
      end
    end
  end
end
