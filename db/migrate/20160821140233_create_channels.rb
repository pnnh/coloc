class CreateChannels < ActiveRecord::Migration
    def change
        create_table :channels do |t|
            t.references :user
            t.string :title
            t.string :description
            t.string :tags
            t.string :ctype

            t.timestamps null: false
        end
    end
end
