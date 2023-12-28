class AddUserInformationToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :mattermost_id, :string
    add_column :users, :activated, :boolean, default: false
    add_column :users, :role, :integer, default: 0
  end
end
