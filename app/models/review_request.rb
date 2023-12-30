class ReviewRequest < ApplicationRecord
  belongs_to :reviewer, class_name: 'User'
  belongs_to :reviewee, class_name: 'User'

  validates :url, presence: true
  validates :message, presence: true

  before_validation :set_reviewer, on: :create
  before_validation :set_message, on: :create

  def notify
    # TODO: Send notification to reviewer
  end

  private

  def set_reviewer
    self.reviewer = reviewer.present? ? reviewer : User.where.not(id: reviewee_id).sample
  end

  def set_message
    self.message = message.present? ? message : "レビューお願いします！"
  end
end
