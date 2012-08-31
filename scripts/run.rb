#!/usr/bin/env ruby

puts "------> starting redis"
%x|

  redis-server /usr/local/etc/redis.conf
  redis-server /usr/local/etc/redis_6377.conf
  redis-server /usr/local/etc/redis_6378.conf
|

puts "-------> redis prepared!"

puts "---------> starting goliath server "
%x|
  ruby config/route.rb sign_up -sv -e development  -p 9000 -d
  ruby config/route.rb password -sv -e development  -p 9001 -d
  ruby config/route.rb login -sv -e development  -p 9002 -d
  ruby config/route.rb reg_choice -sv -e development  -p 9003 -d
|
puts "----------> ok, goliath prepared!"
