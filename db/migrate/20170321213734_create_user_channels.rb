class CreateUserChannels < ActiveRecord::Migration
    def change
        create_table :user_channels do |t|
            t.references :user
            t.references :channel
            t.integer    :vote, default: 0
            t.integer    :favorite, default: 0

            t.timestamps
        end
    end
end
