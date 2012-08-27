$: << "../../app" << "./app" << "../../lib" << "./lib"

# # models
require 'models/redis_record'
require 'models/user'


# # lib
require 'evented_distributed'
require 'redis_distributed'
require 'arithmetic/bijective'

# constant define
SALT = "sdfsdfaQEWRWRFSf11342SFWERGSDFSRas2342D"

# Bid
