class CreateChannelFollows < ActiveRecord::Migration
    def change
        create_table :channel_follows do |t|
            t.references :user, index: true
            t.references :channel, index: true
            t.integer    :vote, default: 0
            t.integer    :favorite, default: 0

            t.timestamps
        end
    end
end
