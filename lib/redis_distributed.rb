require 'yaml'
require 'redis/distributed'

module If
  class RedisDistributed

    def self.node
      unless @distributed 
        hosts           = configuration["distributed"]
        urls,password   = hosts["urls"],hosts["password"]
        @distributed    = Redis::EventedDistributed.new(urls, :password => password)
      end
      @distributed	
    end

    def self.configuration
      unless @redis_config
        config_path  = File.join(File.dirname(__FILE__), '..', 'config', 'redis.yml')
        @redis_config = YAML.load(File.new(config_path))
      end
      @redis_config
    end

    

  end
end