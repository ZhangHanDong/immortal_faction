require 'digest/sha1'

class User < RedisRecord::Base
 
  #sign_up

  def build
    user_id = incrby("accounts:count", 1)
    username = Bijective.bijective_encode user_id
    save([['user_id', user_id], ['username', username]])
    return username
  end

  def current_user_counts
    get("accounts:count")
  end

  # attrs = [[k, v], [k1, v1]]
  def save(attrs)
    attrs.each do |attr|
      hmset("accounts:user_lists", "#{attr[0]}", "#{attr[1]}")
    end
  end

  # list
  def device_info_save(device_type, device_code)
    lpush("accounts:devices:#{current_user_count}", "#{device_type}:#{device_code}")
  end

  #login

  

  def current_user
    
  end

  #profile


  # public
  def generate_token
    Digest::MD5.hexdigest "#{SecureRandom.hex(10)}-#{Time.now.to_s}"
  end

  # query

  def device_infos
    lrange "accounts:devices:#{current_user}"
  end

  def user_lists
    hgetall("accounts:user_lists")
  end

  def login?(name, pwd)
    #TODO
  end

  protected

    def generate_password(pwd)
      Digest::SHA1.hexdigest "#{pwd}#{SALT}"
    end
end