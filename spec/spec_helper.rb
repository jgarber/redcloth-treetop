require 'rubygems'
require 'treetop'
require 'spec'
 
$: << File.join(File.dirname(__FILE__), '..', 'lib')

require 'redcloth/ast'
require 'redcloth/parser/treetop_ext'
require 'redcloth/parser/common'


Spec::Runner.configure do |config|
  
end