require 'digest/sha1'

class User < RedisRecord::Base
 
  def nick_name
    get("accounts:nick:#{current_user_count}") || ""
  end

  def generate_token
    Digest::MD5.hexdigest "#{SecureRandom.hex(10)}-#{Time.now.to_s}"
  end

  def new_user_id
    incrby("accounts:count", 1)
  end

  def current_user_count
    get("accounts:count")
  end

  def uniq_name
    Bijective.bijective_encode current_user_count.to_i
  end

  def save(pwd)
    hmset("accounts:user_lists", "#{current_user_count}", 'name', "#{uniq_name}", 'nick', "#{nick_name}", 'pwd', "#{generate_password(pwd)}")
  end

  def device_info_save(device_type, device_code)
    hset("accounts:devices", "#{current_user_count}", "#{device_type}:#{device_code}")
  end

  def device_infos
    hgetall "accounts:devices"
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