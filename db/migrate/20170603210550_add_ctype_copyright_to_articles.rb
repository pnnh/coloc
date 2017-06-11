class AddCtypeCopyrightToArticles < ActiveRecord::Migration
    def change
        # 文章内容类型 md Markdown, html HTML
        add_column :articles, :ctype, :string,
                   default: 'md', null: false
        # 文章版权说明
        add_column :articles, :copyright, :string,
                   default: ''
    end
end
