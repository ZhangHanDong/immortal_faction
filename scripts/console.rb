#!/usr/bin/env ruby

require 'irb'
require 'irb/completion'

$: << "../../config" << "./config"
require 'boot'

puts "Loading IF environment ... "

IRB.start