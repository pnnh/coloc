class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.references :user
      t.references :channel
      t.string :title
      t.string :content, default: ''
      t.string :tags, default: ''
      t.integer :plus, default: 0
      t.integer :minus, default: 0

      t.timestamps
    end
  end
end
