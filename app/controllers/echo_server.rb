require 'goliath'
require 'faye/websocket'

class EchoServer < Goliath::API
  def response(env)
    ws = Faye::WebSocket.new(env)

    ws.onmessage = lambda do |event|
      ws.send(event.data)
    end

    ws.rack_response
  end
end