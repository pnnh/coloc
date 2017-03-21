class CreateSlogans < ActiveRecord::Migration
  def change
    create_table :slogans do |t|
      t.string :words

      t.timestamps
    end
    add_index :slogans, :words, unique: true
  end
end
