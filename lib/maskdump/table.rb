require 'active_record'

module Maskdump
  class Table
    attr_reader :name

    def initialize(name)
      @name = name
    end

    def records
      @records ||= result.to_ary
    end

    def columns
      @columns ||= result.columns
    end

    private

    def result
      @result ||= conn.select_all("SELECT * FROM #{@name};")
    end

    def conn
      @conn ||= ActiveRecord::Base.connection
    end
  end
end
