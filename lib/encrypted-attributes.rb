$:.unshift File.dirname(__FILE__)

require 'simple_aes'
require 'encrypted_attributes'
require 'encrypted_attributes/railtie' if defined? ::Rails::Railtie
