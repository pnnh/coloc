# coding: utf-8

module ApplicationHelper
    def full_title(page_title)
        base_title = '宇哲'
        if page_title.empty?
          base_title
        else
          "#{page_title} - #{base_title}"
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
        "/contents/#{c.id}/#{parse_controller(c.entity_type)}/#{c.entity_id}"
    end

    def content_current
        if !params[:id].nil?
          "/contents/#{params[:content_id]}/#{params[:controller]}/#{params[:id]}"
        else
            content(Content.find(params[:content_id]))
        end
    end

    def content_parent
      content(Content.find(params[:content_id]).parent)
    end

    def edit_content(c)
      "/contents/#{c.id}/#{parse_controller(c.entity_type)}/#{c.entity_id}/edit"
    end

    def edit_current_content
        "/contents/#{params[:content_id]}/#{params[:controller]}/#{params[:id]}/edit"
    end

    def new_content(c)
        "/contents/#{params[:content_id]}/#{parse_controller(c)}/new"
    end

    def contents_current
        "/contents/#{params[:content_id]}/#{params[:controller]}"
    end
end
