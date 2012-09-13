$: << "../../lib" << "./lib"

require 'faye_app'

Faye::WebSocket.load_adapter('goliath')
run FayeApp