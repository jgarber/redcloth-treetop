module RedCloth
  module Ast
    class InlineElement
      
      def initialize(opts={}, contents=nil)
        @opts = opts
        @contents = contents
      end
      
      def to_sexp
        [@opts.delete(:type), @opts, contents]
      end
      
      def contents
        @contents.inject([]) do |a, e|
          if e.is_a?(String)
            if a.last.is_a?(String)
              a.last << e
            else
              a << e
            end
          else
            a << e.to_sexp
          end
          a
        end
      end
      
    end
  end
end