require 'goliath'
require 'faye/websocket'

class EchoServer < Goliath::API
  def response(env)
    ws = Faye::WebSocket.new(env)

    ws.onmessage = lambda do |event|
      env.logger.info "--------event data--> #{event.data}"
      ws.send(event.data)
    end
 
    env.logger.info "-----rack response----> #{ws.rack_response}"

    ws.rack_response
  end
end