$: << "../../app" << "./app" << "../../lib" << "./lib"

# # models
require 'models/redis_record'
require 'models/user'


# # lib
require 'evented_distributed'
require 'redis_distributed'
require 'arithmetic/bijective'
require "pb/ErrorGPB.pb"
require "pb/LoginGPB.pb"
require "pb/RegAttrGPB.pb"
require "pb/MainDataGPB.pb"

# constant define
SALT = "sdfsdfaQEWRWRFSf11342SFWERGSDFSRas2342D"

# Bid
