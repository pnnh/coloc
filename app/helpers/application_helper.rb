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

    def truncate(content)
        content.truncate(100, separator: ' ')
    end
end
