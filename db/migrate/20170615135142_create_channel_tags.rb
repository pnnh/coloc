class CreateChannelTags < ActiveRecord::Migration
  def change
    create_table :channel_tags do |t|
      t.references :channel
      t.string :tag, null: false
      t.integer :score, default: 1

      t.timestamps
    end
  end
end
