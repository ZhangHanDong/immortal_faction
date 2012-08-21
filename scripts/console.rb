#!/usr/bin/env ruby

require 'irb'
require 'irb/completion'

$: << "../../config" << "./config"
require 'routes'

puts "Loading IF environment ... "

IRB.start