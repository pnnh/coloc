class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.references :user
      t.references :parent, index: true
      t.references :entity, polymorphic: true, index: true
      t.string     :name

      t.timestamps null: false
    end
  end
end
