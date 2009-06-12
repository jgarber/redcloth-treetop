require 'redcloth/ast'
require 'redcloth/parser/treetop_ext'
require 'redcloth/parser/common'
require 'redcloth/parser/list'
require 'redcloth/parser/textile_doc'

module RedCloth
  # Classes in this module parse feature files and translate the parse tree 
  # (concrete syntax tree) into an abstract syntax tree (AST) using
  # <a href="http://martinfowler.com/dslwip/EmbeddedTranslation.html">Embedded translation</a>.
  #
  # The AST is built by the various <tt>#build</tt> methods in the parse tree.
  #
  # The AST classes are defined in the RedCloth::Ast module.
  module Parser
    
  end
end