class Group < ApplicationRecord
  validates :name, presence: true
  validates :mattermost_channel_id, presence: true

  has_many :group_members, dependent: :destroy
  has_many :users, through: :group_members

  def added_at(user)
    group_members.find_by(user:).created_at
  end

  def user_order_by_reviewer_amount(reviewee_id)
    users.where.not(id: reviewee_id)
         .joins('LEFT JOIN review_requests ON review_requests.reviewer_id=users.id')
         .group(:id).order('count(review_requests.id)').first
  end

  def joined?(user)
    users.include?(user)
  end
end
