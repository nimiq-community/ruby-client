=begin
  Copyright 2020 Nimiq community.

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
=end

require_relative "nimiq/version"
require_relative "rpc"
require_relative "api"
require "json"

module Nimiq
  class Error < StandardError; end # :nodoc: all

  attr_reader :rpc # :nodoc: all

  class Client
    include Api

    def initialize(opts)
      puts "Connecting to #{opts[:host]}:#{opts[:port]}"
      return @rpc = ClientRPC::Connect.new(opts)
    end

    # Sends a raw request to the Nimiq node.
    def request(name, params = nil)
      return @rpc.request(name, params)
    end

    # Ping the Nimiq node.
    def ping
      @rpc.ping_node
      @pingres = @rpc.instance_variable_get(:@pingres)
    end
  end
end
