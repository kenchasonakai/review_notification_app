class AddGithubIdToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :github_id, :string
  end
end
