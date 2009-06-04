module TextileDoc
  class List < Treetop::Runtime::SyntaxNode
    def eval(env={})
      operator.apply(operand_1.eval(env), operand_2.eval(env))      
    end
  end
  
  class ListItem < Treetop::Runtime::SyntaxNode
    def eval(env={})
      operator.apply(operand_1.eval(env), operand_2.eval(env))      
    end
  end
end
