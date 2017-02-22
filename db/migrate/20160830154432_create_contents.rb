class CreateContents < ActiveRecord::Migration
    def change
        create_table :contents do |t|
            t.references :user
            t.references :channel
            t.references :entity, polymorphic: true, index: true
            t.string :title
            t.string :description

            t.timestamps null: false
        end
    end
end
