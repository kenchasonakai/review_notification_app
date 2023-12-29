class ReviewRequest < ApplicationRecord
  belongs_to :reviewer, class_name: 'User'
  belongs_to :reviewee, class_name: 'User'

  validates :url, presence: true

  def notify
    # TODO: Send notification to reviewer
  end
end
