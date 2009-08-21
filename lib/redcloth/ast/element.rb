module RedCloth
  module Ast
    class Element
      attr_reader :contained_elements
      attr_reader :type
      attr_reader :opts
      
      def initialize(opts={}, contained_elements=[])
        @opts = opts
        @type = @opts.delete(:type)
        @contained_elements = contained_elements
      end
      
      def to_sexp
        [type, @opts, contained_elements.map {|e| e.to_sexp }]
      end
      
      def accept(visitor)
        visitor.send(type, self)
      end
      
    end
  end
end