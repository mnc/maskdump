# Mozaic

*this is develop version*

Mozaic provides tools to help you dump data from RDBMS and mask their specified columns.  
You can use default masking method for masking data.  
For example, tel, email, blackout and so on. Otherwise, you program for custom masking method.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mozaic'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install mozaic
```

## Usage


1. define mask target column and database settings

```yml
# tables.yml
---
user: root
host: localhost
port: 3306
db: 
  name: sample_development
  rdbms: mysql
tables: 
  - name: owners
    columns: 
      - name: phone_number
        method: tel # Data Masking Method
  - name: users
    columns: 
      - name: mail
        method: email # Data Masking Method
```

2. execute mozaic command

```
$ mozaic tables.yml --dist sample -p xxxxx
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/mozaic. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

