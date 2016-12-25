class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.references :content, index: true
      t.references :entity, polymorphic: true, index: true
      t.string     :name
      t.string     :description

      t.timestamps null: false
    end
  end
end
