require 'rubygems'
gem 'treetop', "> 1.2.5"
require 'treetop'
require 'spec'
 
$: << File.join(File.dirname(__FILE__), '..', 'lib')

require 'redcloth/ast'
require 'redcloth/parser/treetop_ext'

Spec::Runner.configure do |config|
  
end