class RegAttr < RedisRecord::Base
  
  attr_accessor :attribute, :user_id

  def create(options={})
    if options[:user_id] && options[:attribute]
      RegAttr.hmset("imf:reg:#{options[:user_id]}", "user_id", options[:user_id], "attribute", options[:attribute])
      return true
    end
  end


end