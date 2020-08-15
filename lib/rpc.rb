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

require "oj"
require "net/http"

# :nodoc: all
module ClientRPC
  class Connect
    attr_accessor :options, :uri, :ssl

    DEFAULTS = {
      host: "localhost",
      port: 18332,
    # dev: true,
    }.freeze

    def initialize(host)
      @options = DEFAULTS.dup.merge(host.dup)
      @uri = @options[:uri] ? URI(@options[:uri]) : URI(uri_check())
    end

    def request(name, *args)
      puts "\n> #{name}: #{args.join(",")}" if options[:dev]
      response = request_http_post(name, args)
      puts "< #{response.code} #{response.message}" if options[:dev]
      raise Error, response.message unless (200...300).cover?(response.code.to_i)
      begin
        response = Oj.load(response.body, symbol_keys: true, bigdecimal_load: true)
      rescue StandardError => e
        puts "WARN < Failed to parse JSON response: #{e}" if options[:dev]
        raise
      end
      puts "\n> #{name}: #{args.join(",")}" if options[:dev]
      puts response[:result] if options[:dev]
      raise Error, response[:error] if response[:error]
      response[:result]
    end

    def ping_node
      user = uri.user
      pass = uri.password
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true if @ssl
      request = Net::HTTP::Get.new(uri.request_uri)
      request.basic_auth(user, pass)
      request.body = request_body("", nil)
      request["Content-Type"] = "application/json".freeze
      response = http.request(request)
      @pingres = (response.code).to_i.dup
    end

    private

    def request_http_post(name, params)
      user = URI.decode(uri.user)
      pass = URI.decode(uri.password)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true if @ssl
      request = Net::HTTP::Post.new(uri)
      request.basic_auth(user, pass)
      request.body = request_body(name, params)
      request["Content-Type"] = "application/json".freeze
      http.request(request)
    end

    def request_body(name, params)
      Oj.dump({
        id: 0,
        jsonrpc: "2.0",
        method: name,
        params: params,
      }, mode: :compat)
    end

    def uri_check
      if (options[:host].include? "http://" or options[:host].include? "https://")
        host = options[:host]
        newhost = url_strip(host.dup)
        if (options[:host].include? "https")
          @ssl = true
          if options[:pass]
            return "https://#{options[:user]}:#{URI.encode(options[:pass])}@#{newhost}:#{options[:port]}"
          else
            return "https://#{options[:user]}:@#{newhost}:#{options[:port]}"
          end
        else
          if options[:pass]
            return "http://#{options[:user]}:#{URI.encode(options[:pass])}@#{newhost}:#{options[:port]}"
          else
            return "http://#{options[:user]}:@#{newhost}:#{options[:port]}"
          end
        end
      else
        if options[:pass]
          return "http://#{options[:user]}:#{URI.encode(options[:pass])}@#{options[:host]}:#{options[:port]}"
        else
          return "http://#{options[:user]}:@#{options[:host]}:#{options[:port]}"
        end
      end
    end

    def url_strip(url)
      return url.to_s.sub!(/https?(\:)?(\/)?(\/)?(www\.)?/, "") if url.include?("http")
      url.to_s.sub!(/(www\.)?/, "") if url.include?("www")
    end

    class Error < RuntimeError; end
  end
end
