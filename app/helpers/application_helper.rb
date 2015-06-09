# coding: utf-8
require 'github/markup'

module ApplicationHelper
  def full_title(page_title)
    base_title = "宇哲"
    if page_title.empty?
      base_title
    else
      "#{page_title} - #{base_title}"
    end
  end
  
  def markdown(string)
    RDiscount.new(string).to_html.html_safe
  end
  
  def coderay(text, lang)
    CodeRay.scan(text, lang).div
  end

  def markup(markup, content)
    GitHub::Markup.render("." + markup, content).strip.force_encoding("utf-8")
  end
end
