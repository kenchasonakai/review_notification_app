class SorceryCore < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :nickname

      t.timestamps                null: false
    end
  end
end
