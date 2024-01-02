class CreateGroups < ActiveRecord::Migration[7.1]
  def change
    create_table :groups do |t|
      t.string :name, null: false
      t.string :mattermost_channel_id, null: false

      t.timestamps
    end
  end
end
