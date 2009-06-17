module RedCloth
  module Ast
    class InlineElement < Inline
      attr_reader :inline_elements
      
      def initialize(opts={}, inline_elements=nil)
        @opts = opts
        @inline_elements = inline_elements
      end
      
      def to_sexp
        [@opts.delete(:type), @opts, contents_to_sexp]
      end
      
    end
  end
end