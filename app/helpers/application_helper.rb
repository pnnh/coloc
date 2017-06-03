# coding: utf-8

module ApplicationHelper
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

    def execsql(query, params)
        cmd = ActiveRecord::Base.send :sanitize_sql, params.insert(0, query)
        @channels = ActiveRecord::Base.connection.execute(cmd)
    end
end
