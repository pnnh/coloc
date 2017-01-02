# coding: utf-8

module ContentsHelper
    def parse_type(word)
        word.singularize.capitalize
    end

    def parse_controller(word)
        word.pluralize.downcase
    end

    def content_type
        type = params[:content_type]
        @content_type ||= type.to_s if !type.nil? && !type.blank?
        @content_type ||= params[:controller]
    end

    def content_id
        id = params[:content_id]
        @content_id ||= id.to_i if !id.nil? && !id.blank?
        @content_id ||= params[:id].to_i
    end

    def current_content
        unless content_id.nil?
            @current_content ||= Content.find(content_id)
        end
    end

    def parent_content
        current = current_content
        unless current.nil?
            @parent_content ||= current.id == 1 ? current : current.parent
        end
    end

    def content_url(c = current_content, ct = content_type)
        "/#{parse_controller(ct)}/#{c.id}"
    end

    def content_entity_url(c = current_content, ct = content_type)
        "/#{parse_controller(ct)}/#{c.id}/#{parse_controller(c.entity_type)}/#{c.entity_id}"
    end

    def content_entities_url(ct = content_type, c = current_content, et)
        "/#{parse_controller(ct)}/#{c.id}/#{parse_controller(et)}"
    end

    def edit_content_entity_url(ct = content_type, c = current_content)
        "/#{parse_controller(ct)}/#{c.id}/#{parse_controller(c.entity_type)}/#{c.entity_id}/edit"
    end

    def new_content_entity_url(ct = content_type, c = current_content, et)
        "/#{parse_controller(ct)}/#{c.id}/#{parse_controller(et)}/new"
    end

    def parent_content_entity_url
        content_entity_url(parent_content)
    end
end
