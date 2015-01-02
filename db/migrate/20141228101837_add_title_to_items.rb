class AddTitleTokenToItems < ActiveRecord::Migration
  def change
    add_column :items, :title, :string
    add_index :items, :title
  end
end
