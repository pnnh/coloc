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

    def update_time(time)
        now = Time.new
        sub = now - time
        if sub <= 60
            '刚刚'
        elsif sub <= 300
            '5分钟内'
        elsif sub <= 600
            '10分钟内'
        elsif sub <= 1800
            '30分钟内'
        elsif sub <= 3600
            '1小时内'
        else
            day = Date.new(now.year, now.month, now.day)
            if time > day
                time.strftime("今天 %H:%M")
            elsif time > day - 1
                time.strftime("昨天 %H:%M")
            elsif time > day - 2
                time.strftime("前天 %H:%M")
            else
                time.strftime("%m月%d日 %H:%M")
            end
        end
    end
end
