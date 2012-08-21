class User < RedisRecord::Base
 

  def uniq_name
  	name = generate_user_name
  	exist?(name) ? generate_user_name : name
  end

protected

  def generate_user_name
    pool = ('a'..'z').to_a + (1..9).to_a
    name = (0..5).map{ pool[rand(pool.length)]}.join
    return name
  end

  def exist?(name)
    #TODO
    false
  end

end