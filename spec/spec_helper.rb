require 'rspec'

$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'slippers'
require 'ostruct'
require 'date'
require 'mocha'
require 'tempfile'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
end
