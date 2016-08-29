class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :title
      t.string :content
      t.integer :channel_id

      t.timestamps null: false
    end
    add_index :tags, :title
  end
end
