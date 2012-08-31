# encoding: UTF-8

class Device < RedisRecord::Base

  attr_accessor :device_type, :device_code, :user_id

  def create(options={})
  	return if (options.keys.size != 3)
    Device.lpush("imf:device:#{options[:user_id]}", "#{options[:device_type]}:#{options[:device_code]}") if options[:device_type] && options[:device_code] && options[:user_id]
  end

end