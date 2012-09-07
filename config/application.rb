# encoding: UTF-8

$: << "../../app" << "./app" << "../../lib" << "./lib"

#controllers
require "controllers/base"

# # models
require 'models/redis_record'
require 'models/user'
require 'models/device'
require 'models/reg_attr'


# # lib
require 'evented_distributed'
require 'redis_distributed'
require 'arithmetic/bijective'
require 'arithmetic/password_handle'
require "pb/ErrorGPB.pb"
require "pb/LoginGPB.pb"
require "pb/RegAttrGPB.pb"
require "pb/MainDataGPB.pb"

# constant define
SALT = "sdfsdfaQEWRWRFSf11342SFWERGSDFSRas2342D"

# Error infos
LOGIC_ERROR_INFOS = {
  code0: {code: 0, text: 'good'},
  code1: {code: 1, text: '密码错误！'},
  code2: {code: 2, text: '无效的token!'},
  code3: {code: 3, text: '没有找到此用户!'}
}
