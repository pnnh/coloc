class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.boolean :admin, default: false
      t.string :remember_token
      t.string :password_digest

      t.timestamps
    end
    add_index :users, :remember_token
    add_index :users, :email, unique: true
  end
end
