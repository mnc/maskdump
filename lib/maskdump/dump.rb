require 'open3'

module Maskdump
  class Dump
    def initialize(db, output_filename)
      @db = db.to_s
      @output_filename = output_filename
    end

    def run
      Open3.popen3("pg_dump -d #{@db} -f #{@output_filename}") do |stdin, stdout, stderr, thr|
        stdin.close
        stderr.each{ |line| puts line }
        stdout.each{ |line| puts line }
        thr.join
      end
    end
  end
end

