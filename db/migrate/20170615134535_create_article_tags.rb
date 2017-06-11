class CreateArticleTags < ActiveRecord::Migration
  def change
    create_table :article_tags do |t|
      t.references :article
      t.string :tag, null: false
      t.integer :score, default: 1
    end
  end
end
