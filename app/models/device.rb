class Device < RedisRecord::Base

  attr_accessor :device_type, :device_code, :user_id

  def update(options={})
  	return if (options.keys.size != 3)
    Device.lpush("imf:device:#{options[:user_id]}", "#{options[:device_type]}:#{options[:device_code]}") if options[:device_type] && options[:device_code] && options[:user_id]
  end


  def self.find(user_id)
  	attributes  = Device.lrange "imf:device:#{user_id}"
    attributes.nil? || 0 == attributes.size  ? nil : serialize_from_hash(attributes)
  end

end