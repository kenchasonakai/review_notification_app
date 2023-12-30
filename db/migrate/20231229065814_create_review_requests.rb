class CreateReviewRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :review_requests do |t|
      t.references :reviewee, null: false
      t.references :reviewer, null: false
      t.string :url, null: false
      t.text :message, null: false

      t.timestamps
    end
    add_foreign_key :review_requests, :users, column: :reviewee_id
    add_foreign_key :review_requests, :users, column: :reviewer_id
  end
end
