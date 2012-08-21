$: << "../../config" << "./config"

require 'boot'

class Routes < Goliath::API

  # routes
  
  def response(env)
    [400, {}, "no route!"]
  end

end