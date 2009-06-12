require 'redcloth/ast/textile_doc'
require 'redcloth/ast/paragraph'
require 'redcloth/ast/list'
require 'redcloth/ast/list_item'

module RedCloth
  # Classes in this module represent the Abstract Syntax Tree (AST)
  # that gets built when a textiled document is parsed.
  #
  # AST classes don't expose any internal data directly. This is
  # in order to encourage a less coupled design in the classes
  # that operate on the AST. The only public method is #accept.
  #
  # The AST can be traversed with a visitor. See RedCloth::Format::HTML
  # for an example.
  module Ast
  end
end