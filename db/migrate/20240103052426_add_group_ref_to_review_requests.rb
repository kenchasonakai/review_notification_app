class AddGroupRefToReviewRequests < ActiveRecord::Migration[7.1]
  def change
    add_reference :review_requests, :group, null: false, foreign_key: true
  end
end
