require 'parslet'

module Maskdump
  class Parser
    class << self
      def parse(data)
        parser.parse(data)
      end

      private

      def parser
        @parser ||= ParsletParser.new
      end
    end
  end

  class ParsletParser < Parslet::Parser

    root(:statements)

    rule(:statements) do
      statement.repeat
    end

    rule(:statement) do
      copy | newline | something | spaces
    end

    rule(:delimiter) do
      str(";")
    end

    rule(:newline) do
      str("\n") >> str("\r").maybe
    end

    #
    # space except newline (tab may not be included)
    #
    rule(:space) do
      match('[^\S\r\n]')
    end

    rule(:spaces) do
      space.repeat(1)
    end

    rule(:space?) do
      space.repeat
    end

    rule(:tab) do
      match('\t')
    end

    #
    # some word except newline and space. include special characters like '-'
    #
    rule(:something) do
      match('\R').absent? >> space.absent? >> match('\S').repeat(1)
    end

    #
    # some value except newline and tab. include special characters like '-', space
    #
    rule(:column_value) do
      (
        match('\R').absent? >> match('\t').absent? >> 
        (
          match('\S') | match('\s')
        )
      ).repeat(1)
    end

    #
    # some word except special characters like '-'
    #
    rule(:word) do
      match('\w').repeat(1)
    end

    rule(:table_name) do
      word
    end

    rule(:column_definitions) do
      parenthetical(comma_separated(word.as(:column_definition)))
    end

    rule(:column_values) do
      tab_separated(column_value.as(:value))
    end

    rule(:copy) do
      (
        ignore_case_str('copy') >> spaces >> table_name.as(:table) >> spaces >> column_definitions >> 
        spaces >> ignore_case_str('from ') >> ignore_case_str('stdin') >> delimiter >> newline >> 
        (str('\.').absent? >> column_values >> newline).as(:values).repeat(1) >> str('\.')
      ).as(:copy)
    end

    def non(sequence)
      (sequence.absent? >> any).repeat
    end

    def comma_separated(value)
      value >> (str(",") >> space? >> value).repeat
    end

    def parenthetical(value)
      str("(") >> space? >> value >> space? >> str(")")
    end

    def tab_separated(value)
      value >> (tab >> value).repeat
    end

    def space_separated(value)
      value >> (spaces >> value).repeat
    end

    def ignore_case_str(value)
      str(value.downcase) | str(value.upcase)
    end
  end
end
