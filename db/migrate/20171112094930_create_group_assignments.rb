class CreateGroupAssignments < ActiveRecord::Migration
  def change
    create_table :group_assignments do |t|
      t.references :user, index: true
      t.integer :group

      t.timestamps null: false
    end
    add_foreign_key :group_assignments, :users
    add_index :group_assignment, [:user, :group], :unique => true
  end
end
