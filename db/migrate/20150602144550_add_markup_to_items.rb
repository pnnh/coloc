class AddMarkupToItems < ActiveRecord::Migration
  def change
    add_column :items, :markup, :string
  end
end
