module Maskdump
  class Runner
    def initialize
    end

    def run
      output_filename = 'rfqcloud'
      #dump = Maskdump::Dump.new('rfqcloud_development', output_filename)
      #dump.run
      dump_data = File.open(output_filename, 'r') do |f|
        f.read
      end
      puts dump_data.class
      parse = Maskdump::Parser.parse(dump_data)
      puts "END: parse"
      parse
    end
  end
end

