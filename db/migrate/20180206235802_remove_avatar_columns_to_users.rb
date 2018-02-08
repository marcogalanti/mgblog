class RemoveAvatarColumnsToUsers < ActiveRecord::Migration[5.1]
  def up
  #remove_attachment :users, :avatar
  end
  def down
  #add_attachment :users, :avatar
  end
end
