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
      copy | comment | newline | something | spaces
    end

    rule(:delimiter) do
      str(";")
    end

    rule(:newline) do
      str("\n") >> str("\r").maybe
    end

    rule(:comment) do
      (
        (str("#") | str("--")) >> non(newline) >> newline
      ) 
      #| (
      #  str("/") >> space? >> str("*") >>
      #    ((str("*") >> space? >> str("/")).absent? >> any).repeat >> (str("*") >> space? >> str("/"))
      #)
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

    #
    # some word except newline and space. include special characters like '-'
    #
    rule(:something) do
      match('\R').absent? >> space.absent? >> match('\S').repeat(1)
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
      space_separated(something.as(:column_value))
    end

    rule(:copy) do
      (
        str('COPY') >> spaces >> table_name.as(:table) >> spaces >> column_definitions >> 
        spaces >> str('FROM stdin') >> delimiter >> newline >> column_values >> newline >> str('\.')
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

    def space_separated(value)
      value >> (spaces >> value).repeat
    end
  end
end
