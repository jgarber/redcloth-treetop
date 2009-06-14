module RedCloth
  module Ast
    class InlineElement
      
      def initialize(opts={}, contents=nil)
        @opts = opts
        @contents = contents
      end
      
      def to_sexp
        [@opts.delete(:type), @opts, @contents]
      end
      
    end
  end
end