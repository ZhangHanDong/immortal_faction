$: << "../../config" << "./config"
require 'boot'

case "#{ARGV[0]}"
when 'login'
  require 'controllers/login'
  puts "-----> login"
when 'sign_up'
  require 'controllers/sign_up'
  puts "-------> sign_up"
when 'reg_choice'
  require 'controllers/reg_choice'
  puts "------> reg_choice"
end

