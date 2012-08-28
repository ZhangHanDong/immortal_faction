module RedisRecord

  class Base

    def hset(*args)
      If::RedisDistributed.node.hset *args
    end

    def hmset(*args)
      If::RedisDistributed.node.hmset *args
    end

    def hmget(*args)
      If::RedisDistributed.node.hmget *args
    end

    def hgetall(*args)
      If::RedisDistributed.node.hgetall *args
    end

    def incrby(*args)
      If::RedisDistributed.node.incrby *args
    end

    def set(*args)
      If::RedisDistributed.node.set *args
    end

    def get(*args)
      If::RedisDistributed.node.get *args
    end

    def lpush(*args)
      If::RedisDistributed.node.lpush *args
    end

    def lrange(*args)
      If::RedisDistributed.node.lrange *args
    end
  end

end