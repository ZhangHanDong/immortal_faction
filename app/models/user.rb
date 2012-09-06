# encoding: UTF-8

require 'digest/sha1'

class User < RedisRecord::Base
  
  attr_accessor :username, :id, :password, :token, :nick, :email

  def self.create
    @id = incrby("imf:user:counts", 1)
    @username = rand(36**6).to_s(36)
    hmset("imf:user:#{@username}", "id", @id, "username", @username)
    return User.find @username
  end

  def self.all
    users =  keys("imf:user:*").inject([]) do |u, k|
      username = k.split(':').last
      u << User.find(username)
    end
  end

  #just can modify password, nick, token
  def update(options={})
    safe_options = [:password, :nick, :token] & options.keys
    unless safe_options.empty?
      options.keys.each do |key|
        if key == :password
          sha_password = User.generate_password options["#{key}".to_sym]
          User.hmset("imf:user:#{self.username}", "#{key}", sha_password)
        else
          User.hmset("imf:user:#{self.username}", "#{key}", options["#{key}".to_sym])
        end
      end
    end
  end

  def current_user_counts
    User.get("imf:user:counts")
  end

  def auth_login(pwd)
    return self.password == User.generate_password(pwd)
  end

  def generate_token
    Digest::MD5.hexdigest "#{SecureRandom.hex(10)}-#{Time.now.to_s}"
  end

  def current_user?(params_token)
    self.token == params_token
  end

  protected

    def self.generate_password(pwd)
      Digest::SHA1.hexdigest "#{pwd}#{SALT}"
    end
end