class EchoServer < Goliath::API
  def response(env)
    FayeApp.call(env)
  end
end