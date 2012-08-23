require "redis/distributed"
require "redis/hash_ring"
require "redis"
require "redis/connection/synchrony"

class Redis
  class EventedDistributed < Redis::Distributed

    def initialize(urls, options = {})
      # super
      @tag = options.delete(:tag) || /^\{(.+?)\}/
      @default_options = options
      @ring = HashRing.new(urls.map { |url| EventMachine::Synchrony::ConnectionPool.new(:size => 5) do
        Redis.connect(:url => url, :password => options[:password])
      end })
      @subscribed_node = nil
    end

  end
end