class CreateInteractions < ActiveRecord::Migration
    def change
        create_table :interactions do |t|
            t.references :user
            t.references :channel

            t.timestamps null: false
        end
    end
end
