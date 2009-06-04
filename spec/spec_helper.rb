require 'rubygems'
require 'treetop'
require 'spec'
 
$: << File.join(File.dirname(__FILE__), '..', 'lib')
 
require 'redcloth'
require "redcloth/node_classes"
 
Spec::Runner.configure do |config|
  
end