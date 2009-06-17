module RedCloth
  module Ast
    class Element < Inline
      attr_reader :contained_elements
      
      def initialize(opts={}, contained_elements=nil)
        @opts = opts
        @contained_elements = contained_elements
      end
      
      def to_sexp
        [@opts.delete(:type), @opts, contents_to_sexp]
      end
      
    end
  end
end