#!/usr/bin/env ruby

puts "------> starting redis"
%x|
  redis-server /usr/local/etc/redis.conf
  redis-server /usr/local/etc/redis_6377.conf
  redis-server /usr/local/etc/redis_6378.conf
|
puts "-------> redis prepared!"