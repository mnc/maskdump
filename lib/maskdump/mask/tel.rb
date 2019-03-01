module Maskdump
  module Mask
    class Tel
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
        only_number_tel = record[3..-1].split("-").join
        set_counter_number(only_number_tel)
        fill_in_zero(only_number_tel)
        masked_tel = record[0..2].split("-").join + only_number_tel
        re_insert_hyphen(record, masked_tel)
      end

      def set_counter_number(only_number_tel)
        only_number_tel[0..(@counter.to_s.size - 1)] = @counter.to_s
      end

      def fill_in_zero(only_number_tel)
        (@counter.to_s.size...only_number_tel.size).each do |i|
          only_number_tel[i] = "0"
        end
      end

      def re_insert_hyphen(record, masked_tel)
        indexes = []
        record.scan(/-/) { indexes << $~.offset(0)[0] }
        indexes.each do |i|
          masked_tel.insert(i, "-")
        end
        masked_tel
      end
    end
  end
end
