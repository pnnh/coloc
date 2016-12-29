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

    def content(c)
        "/#{parse_controller(c.entity_type)}/#{c.id}/#{c.entity_id}"
    end

    def content_current
        "/#{params[:controller]}/#{params[:content_id]}/#{params[:id]}"
    end

    def content_parent
        content(Content.find(params[:content_id]).parent)
    end

    def edit_content(c)
      "/#{parse_controller(c.entity_type)}/#{c.id}/#{c.entity_id}/edit"
    end

    def edit_current_content
        "/#{params[:controller]}/#{params[:content_id]}/#{params[:id]}/edit"
    end

    def new_content(c)
        "/#{parse_controller(c)}/#{params[:content_id]}/#{params[:id]}/new"
    end

    def contents_current
        "/#{params[:controller]}/#{params[:content_id]}"
    end
end
