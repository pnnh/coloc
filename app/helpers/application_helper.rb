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

    def trunc_desc(content)
        i = content.index(/\n/)
        (!i.nil? ? content[0..i] : content).truncate(100, separator: ' ')
    end

    def parse_type(word)
        word.singularize.capitalize
    end

    def parse_controller(word)
        word.pluralize.downcase
    end

end
