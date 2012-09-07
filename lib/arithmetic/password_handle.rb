class PasswordHandle
  
  # 密码加密规则为SALT按随机数分割，分别加到password前后
  # 形如: sfsfsfpasswordcsdfs-6 
  # -6代表从第6位分割， 起始计数从1开始。而Ruby里是以0开始。
  def self.decode(pwd)
  	mark = pwd.rindex(/\-/)
  	pwd1 = pwd[0, mark]
    index = pwd[(mark+1), pwd.length].to_i
  	result = pwd1[index..-(SALT.length-index+1)]
  end
  
end