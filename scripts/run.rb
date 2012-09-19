#!/usr/bin/env ruby

puts "---------> starting goliath server "
servers = {:sign_up => 9000, :password => 9001, :login => 9002, :reg_choice => 9003}
servers.each do |k, v|
  %x| touch ./logs/imf_#{v}.log_stdout.log|
  %x| chmod 755 ./logs/imf_#{v}.log_stdout.log|
  path = %x|pwd|.chomp
  %x| ruby config/route.rb #{k} -e prod -p #{v} -l #{path}/logs/imf_#{v}.log -P #{path}/logs/goliath.pid -d |
end
puts "----------> ok, goliath prepared!"
