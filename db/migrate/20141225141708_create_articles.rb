class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
	    t.string :title
      t.string :content
      t.string :slug

      t.timestamps
    end

    add_index :articles, :slug
  end
end
