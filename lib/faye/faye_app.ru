require 'faye'
Faye::WebSocket.load_adapter('thin')

server = Faye::RackAdapter.new(:mount => '/faye', :timeout => 20)

server.bind(:subscribe) do |client_id, channel|
  puts "[  SUBSCRIBE] #{client_id} -> #{channel}"
end

server.bind(:unsubscribe) do |client_id, channel|
  puts "[UNSUBSCRIBE] #{client_id} -> #{channel}"
end

server.bind(:disconnect) do |client_id|
  puts "[ DISCONNECT] #{client_id}"
end

run server