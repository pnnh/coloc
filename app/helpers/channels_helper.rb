# coding: utf-8

module ChannelsHelper
    def contents_path(id, ctype)
        '/channels/' + id.to_s + '/' + ctype.pluralize.downcase
    end
end
