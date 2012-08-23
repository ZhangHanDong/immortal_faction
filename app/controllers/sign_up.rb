$: << "../../config" << "./config"
require 'boot'

class SignUp < ::Goliath::API

  def response(env)

    [200, {}, User.new.uniq_name]
  end


end