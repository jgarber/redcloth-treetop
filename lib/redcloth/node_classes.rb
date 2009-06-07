module TextileDoc
  class Paragraph < Treetop::Runtime::SyntaxNode
    def to_html
      "<p>" + block_text.text_value + "</p>"
    end
  end
  
  class List < Treetop::Runtime::SyntaxNode
    def to_html
      "<ol>" + list_items.map {|e| e.to_html }.join + "</ol>"
    end
    def list_items
      [li] + more_lis.elements.map {|e| e.li } 
    end
  end
  
  class ListItem < Treetop::Runtime::SyntaxNode
    def to_html
      "<li>" + content.text_value + "</li>"
    end
  end
end
