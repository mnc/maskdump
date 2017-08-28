require 'active_support'
require 'active_support/core_ext'

module Mozaic
  class Setting
    DATABASE_ADAPTER = {
      'mysql' => 'mysql2',
      'postgresql' => 'postgresql',
      'sqlite' => 'sqlite3',
    }.freeze

    def initialize(yaml, options)
      @data = YAML.load_file(yaml).with_indifferent_access
      @options = options
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

    def table_settings
      @options[:tables] || @data[:tables]
    end

    private

    def adapter
      DATABASE_ADAPTER[rdbms]
    end

    def db_name
      @options[:db] || @data[:db][:name]
    end
    
    def rdbms
      @data[:db][:rdbms]
    end

    def user
      @options[:user] || @data[:user]
    end

    def password
      @options[:password] || @data[:password]
    end

    def host
      @options[:host] || @data[:host]
    end

    def port
      @options[:port] || @data[:port]
    end
  end
end
