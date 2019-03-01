require 'active_support'
require 'active_support/core_ext'

module Maskdump
  class Setting
    DATABASE_ADAPTER = {
      'mysql' => 'mysql2',
      'postgresql' => 'postgresql',
    }.freeze

    def initialize(yaml, options)
      @yaml = YAML.load_file(yaml).with_indifferent_access
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
      @options[:tables] || @yaml[:tables]
    end

    private

    def adapter
      DATABASE_ADAPTER[rdbms]
    end

    def db_name
      @options[:d] || @yaml[:db][:name]
    end
    
    def rdbms
      @yaml[:db][:rdbms]
    end

    def user
      @options[:u] || @yaml[:user]
    end

    def password
      @options[:p] || @yaml[:password]
    end

    def host
      @options[:h] || @yaml[:host]
    end

    def port
      @options[:port] || @yaml[:port]
    end
  end
end
