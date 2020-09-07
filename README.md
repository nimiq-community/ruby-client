# Nimiq Ruby Client

> Ruby implementation of the Nimiq RPC client specs.

## About

This Nimiq Ruby RPC client will allow you to interact with the Nimiq blockchain, manage transactions and balances, and more. This library covers the current [Nimiq JSON-RPC specification](https://github.com/nimiq/core-js/wiki/JSON-RPC-API#remotejs-client).

# What is Nimiq?

Nimiq is a blockchain that seamlessly runs in your browser. It's fast, easy and fun to use! For more information visit the [Nimiq website](https://www.nimiq.com/).

## Usage

```ruby
require "nimiq-client"

options = {
  host: "http://127.0.0.1",
  port: "8648",
  # user: "user",
  # pass: "pass",
  # uri: "http://USER:PASS@IP:PORT",
}
nimiq = Nimiq::Client.new(options)
consensus = nimiq.consensus()
get_balance = nimiq.get_balance("NQ27 B9ED 98G5 3VH7 FY8D BFP0 XNF4 BD8L TN4B")
puts "Consensus #{consensus}"
puts "My account balance #{get_balance}"
```

## Installation

Via the [Gem](https://rubygems.org/gems/nimiq-client)

```bash
gem install nimiq-client
```

or add it to your `Gemfile`

```bash
gem "nimiq-client"
```

## Documentation

To know more about what you can possibly do using this library, check the [**documentation**](https://nimiq-community.github.io/ruby-client/).

## Build

This section is for developments. If you only want to use this client go to the [Usage](#Usage) section. After cloning the repo, run `bundle` to install the required dependencies.

## Tests

Run tests with

```bash
rspec --format documentation
```

If you are connecting to a private node that requires username and password, set these on the `options` object in the configuration spec file.

Note that it requires a running Nimiq RPC node, to connect to.

## Contributions

This implementation was originally contributed by [jxdv](https://github.com/jxdv/).

Bug reports and pull requests are welcome. Please refer to the [issue tracker](https://github.com/nimiq-community/ruby-client/issues) for ideas.


## License

[Apache 2.0](LICENSE)
