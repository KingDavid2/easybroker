# Easybroker API

This project demonstrates how to create a Ruby client to interact with the EasyBroker API.

## Setup

```shell
  bundle install
```

## Usage

```shell
  irb
```

Inside irb:

```ruby
  require_relative 'easybroker_api'
```

```ruby
  client = EasyBrokerAPI.new(ENV['API_KEY'])
```

```ruby
  response = client.properties(1, 20)
```

## Testing

```ruby
  rspec spec/easybroker_api_spec.rb
```
