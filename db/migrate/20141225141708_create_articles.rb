class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.references :user
      t.string :content

      t.timestamps
    end
  end
end
