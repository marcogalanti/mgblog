class AddUserGroup < ActiveRecord::Migration[5.1]
  def up
      add_column :users, :group, :string, null: false, default: ""
  end
  def down
      remove_column :users
  end
end
