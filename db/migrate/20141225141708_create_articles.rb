class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.references :user
      t.string :title
      t.string :content
      t.string :tags

      t.timestamps
    end
  end
end
