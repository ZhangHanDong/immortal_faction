require 'faye'
require 'eventmachine'

EM.run {
  client = Faye::Client.new('ws://0.0.0.0:9004/faye')
  puts " ---->"
  client.subscribe('/faye1') do |message|
    puts message.inspect
  end

  client.publish('/faye/foo', 'text' => 'Hello world')


}