module RedisRecord

  class Base

    def hset(*args)
      If::RedisDistributed.node.hset *args
    end

    def hmset(*args)
      If::RedisDistributed.node.hmset *args
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

    def hgetall(*args)
      If::RedisDistributed.node.hgetall *args
    end
  end

end