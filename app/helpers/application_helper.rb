# coding: utf-8

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
    when info == articles_path
      "条目"
    when info == users_path
      "用户"
    else
      "信息"
    end
    end

    def parse_type(word)
        word.singularize.capitalize
    end

    def parse_controller(word)
        word.pluralize.downcase
    end

    def truncate(content)
        content.truncate(100, separator: ' ')
    end

    def show_content(c)
        show_content_url(content_id: c.id, controller: parse_controller(c.entity_type), action:'show', id: c.entity_id)
    end
end
