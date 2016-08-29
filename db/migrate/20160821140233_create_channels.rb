class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.string :name
      t.string :description

      t.integer :channel_id
      t.integer :tag_id
      t.integer :plus_number
      t.integer :minus_number

      t.timestamps null: false
    end
  end
end
