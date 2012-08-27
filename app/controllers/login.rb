$: << "../../config" << "./config"
require 'boot'

class Login < ::Goliath::API

  use Goliath::Rack::Validation::RequestMethod, %w(POST)
  use Goliath::Rack::Heartbeat

  def response(env)
    # If::RedisDistributed.node.set('test', 'ok')
    [200, {}, "Login"]
  end


end