class CreateChannelTags < ActiveRecord::Migration[5.0]
  def change
    create_table :channel_tags do |t|
      t.references :channel
      t.string :tag, null: false
      t.integer :score, default: 1
    end
  end
end
