class AddVisibleToChannels < ActiveRecord::Migration
    def change
        # 频道可见性 0 公开 1 私有
        add_column :channels, :visible, :integer,
                   default: 0, null: false
    end
end
