class LoginController < ::Goliath::API

  def response(env)

    [200, {}, "Hello World"]
  end


end