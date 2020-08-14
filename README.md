# Nimiq Blockchain - Ruby RPC Client

> Ruby implementation of the Nimiq RPC client specs.

## Information

Nimiq Ruby RPC client. It will allow you to interact with the Nimiq blockchain, collect data, update data, sync and more. This library covers all the current [Nimiq JSON-RPC specification](https://github.com/nimiq/core-js/wiki/JSON-RPC-API#remotejs-client).

# What is Nimiq?

Inspired by Bitcoin, Nimiq is a blockchain that seamlessly runs in your browser.

Fast, easy and fun to use! for more information visit the [Nimiq website](https://www.nimiq.com/).

## Usage

**Installation:** (**[Gem](https://rubygems.org/gems/nimiq-ruby-client)**)
```
gem install nimiq-ruby-client
```
or add in the `Gemfile`
```
gem "nimiq-ruby-client"
```

**Start using the Nimiq Ruby Client:**

```ruby
require "nimiq-ruby-client"

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

## Documentation

To know more about what you can possibly do using this library, check the [**documentation**](https://jxdv.github.io/ruby-client/).

## Developments

This section is for developments. If you only want to use this client go to the [Usage](#Usage) section. After cloning the repo, run `bundle` to install the required dependencies.

**Testing**: Run tests by typing **`rspec --format documentation`**. If you are connecting to a private node that requires username and password, don't forget to set set these on the `options` object in the configuration spec file.

Note that it requires a running Nimiq RPC node, to connect to.

## Contributions

This implementation was originally contributed by [jxdv](https://github.com/jxdv/).

Bug reports and pull requests are welcome.

## License

[Apache 2.0](LICENSE)
