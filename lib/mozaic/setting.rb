require 'active_support'
require 'active_support/core_ext'

module Mozaic
  class Setting
    DATABASE_ADAPTER = {
      'mysql' => 'mysql2',
      'postgresql' => 'postgresql',
    }.freeze

    def initialize(yaml, options)
      @data = YAML.load_file(yaml).with_indifferent_access
      @options = options
    end

    DATABASE_ADAPTER.keys.each do |adapter_key|
      define_method("#{adapter_key}?") { adapter_key == rdbms }
    end

    def db_setting_hash
      {
        adapter:  adapter,
        host:     host,
        port:     port,
        username: user,
        password: password,
        database: db_name,
      }.with_indifferent_access
    end

    def tables
      @options[:tables] || @data[:tables]
    end

    private

    def adapter
      DATABASE_ADAPTER[rdbms]
    end

    def db_name
      @options[:d] || @data[:db][:name]
    end
    
    def rdbms
      @data[:d][:rdbms]
    end

    def user
      @options[:u] || @data[:user]
    end

    def password
      @options[:p] || @data[:password]
    end

    def host
      @options[:h] || @data[:host]
    end

    def port
      @options[:port] || @data[:port]
    end
  end
end
