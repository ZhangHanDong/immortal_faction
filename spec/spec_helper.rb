$: << "../../config" << "./config"

require "rubygems"
require "bundler"

Bundler.require(:default,:app,:test)

require 'goliath/test_helper'
Goliath.env = :test


require 'routes'

RSpec.configure do |config|
  config.mock_framework = :rspec
end