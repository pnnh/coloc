module ItemsHelper
  def parse_content(content)
    doc = REXML::Document.new(content)
    REXML::XPath.each(doc.root, "node()") do |e|
      if(e.node_type() == :text)
        concat e
      elsif e.node_type() == :element
        if e.name == 'mark'
          if (e.attribute 'lang').to_s == 'markdown'
            concat raw markdown(e.cdatas.first.to_s)
          else
            concat e.cdatas.first
          end
        elsif e.name == 'code'
          concat raw coderay(e.cdatas.first, (e.attribute 'lang').to_s)
        else
          concat e.text
        end
      end
    end
  end
end
