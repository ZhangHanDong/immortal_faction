$: << "../../config" << "./config"
require 'boot'

class Login < ::Goliath::API

  def response(env)
    If::RedisDistributed.node.set('test', 'ok')
    [200, {}, If::RedisDistributed.node.get('test')]
  end


end