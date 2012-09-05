$: << "../../config" << "./config"
require 'boot'

case "#{ARGV[0]}"
when 'login'
  require 'controllers/login'
when 'sign_up'
  require 'controllers/sign_up'
when 'password'
  require 'controllers/password'
when 'reg_choice'
  require 'controllers/reg_choice'
when 'echo_server'
  require 'controllers/echo_server'
end

