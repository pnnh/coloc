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
  
  def info_name(info = "infos")
    case
    when info == "items"
      "条目"
    when info == "users"
      "用户"
    else
      "信息"
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
