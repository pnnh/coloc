class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.references :user
      t.string :title
      t.string :content

      t.timestamps
    end

    add_index :articles, :title
  end
end
