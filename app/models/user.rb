require 'digest/sha1'

class User < RedisRecord::Base
 
  #sign_up

  def build
    user_id = incrby("accounts:count", 1)
    username = Bijective.bijective_encode user_id
    save(username, ['user_id', user_id])
    return username
  end

  def current_user_counts
    get("accounts:count")
  end

  # attrs = [[k, v], [k1, v1]]
  def save(username, attrs)
    attrs.each do |attr|
      hmset("accounts:user_lists:#{username}", "#{attr[0]}", "#{attr[1]}")
    end
  end

  # list
  def device_info_save(device_type, device_code)
    lpush("accounts:devices:#{current_user_count}", "#{device_type}:#{device_code}")
  end

  # public
  def generate_token
    Digest::MD5.hexdigest "#{SecureRandom.hex(10)}-#{Time.now.to_s}"
  end

  # query

  def current_user?(params_username, params_token)
    token = hmget("accounts:user_lists:#{params_username}", "token")
    if params_token == token
      return true
    else
      return false
    end
  end

  def device_infos
    lrange "accounts:devices:#{current_user}"
  end

  def user_lists
    hgetall("accounts:user_lists")
  end

  protected

    def self.generate_password(pwd)
      Digest::SHA1.hexdigest "#{pwd}#{SALT}"
    end
end