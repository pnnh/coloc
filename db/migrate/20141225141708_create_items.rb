class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
	    t.string :title
      t.string :content
      t.string :slug
      t.string :markup

      t.timestamps
    end

    add_index :items, :slug
  end
end
