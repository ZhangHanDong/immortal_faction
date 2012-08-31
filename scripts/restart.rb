#!/usr/bin/env ruby
puts "----------> restarting Goliath Server ..."

pids = %x[ps aux|grep route.rb|grep -v grep|awk '{print $2}'|xargs].chomp.split
pids.each do |pid|
  %x|kill -9 #{pid.to_i}| 
end

%x[ ruby scripts/run.rb]

puts "--------> restared success!"

