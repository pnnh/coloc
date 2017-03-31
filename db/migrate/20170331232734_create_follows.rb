class CreateFollows < ActiveRecord::Migration
    def change
        create_table :follows do |t|
            t.references :user, index: true
            t.references :entity,polymorphic: true, index: true
            t.integer    :vote, default: 0
            t.integer    :favorite, default: 0

            t.timestamps
        end
    end
end
