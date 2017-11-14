class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.boolean :active, :default => true

      t.timestamps null: false
    end

    add_index :users, :phone, unique: true
  end
end
