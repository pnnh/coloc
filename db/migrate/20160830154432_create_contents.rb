class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.references :parent, polymorphic: true, index: true
      t.references :child, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
