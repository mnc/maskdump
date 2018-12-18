module Mozaic
  module Mask
    class Email
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
        _, domain = record.split("@")
        username = Digest::MD5.hexdigest(@counter.to_s)
        "#{username}@#{domain}"
      end
    end
  end
end
