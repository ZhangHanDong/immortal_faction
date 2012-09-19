#!/usr/bin/env ruby
puts "----------> killed Goliath Server ..."

pids = %x[ps aux|grep route.rb|grep -v grep|awk '{print $2}'|xargs].chomp.split
pids.each do |pid|
  %x|kill -9 #{pid.to_i}| 
end

puts "------ killde haproxy server ..."
ha_pids = %x[ps aux|grep haproxy|grep -v grep|awk '{print $2}'|xargs].chomp
%x|sudo kill -9 #{ha_pids.to_i}|

puts "------ killde faye server ..."
faye_pids = %x[ps aux|grep faye|grep -v grep|awk '{print $2}'|xargs].chomp
%x|sudo kill -9 #{faye_pids.to_i}|

puts "------> starting server ..."
%x[ ruby scripts/local_run.rb]

puts "--------> restared success!"

