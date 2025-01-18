# Easybroker API

This project demonstrates how to create a Ruby client to interact with the EasyBroker API.
It provides methods to fetch a list of properties and retrieve details for a specific property by ID.

## Setup

1. Install dependencies:

```shell
  bundle install
```

2. Configure your environment variables in a .env file:

```env
  API_KEY=your_easybroker_api_key
```

## Usage

Open irb

```shell
  irb
```

Load the client

```ruby
  require './easybroker'
```

Fetch all properties:

```ruby
  properties = EasyBroker.properties
  all_properties = properties.all(1, 20)
```

Fetch a property by ID:

```ruby
  properties = EasyBroker.properties
  property = properties.find('property_id')
```

## Testing

```ruby
  rspec spec/
```
