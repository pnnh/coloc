class AddVisibleToArticles < ActiveRecord::Migration
    def change
        # 文章可见性 0 公开 1 匿名
        add_column :articles, :visible, :integer,
                   default: 0, null: false
    end
end
