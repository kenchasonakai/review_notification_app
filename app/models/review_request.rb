class ReviewRequest < ApplicationRecord
  belongs_to :reviewer, class_name: 'User'
  belongs_to :reviewee, class_name: 'User'
  belongs_to :group

  validates :url, presence: true
  validates :message, presence: true

  before_validation :set_reviewer, on: :create
  before_validation :set_message, on: :create

  def notify
    mention_text = "@#{reviewer.mattermost_id} (cc: @#{reviewee.mattermost_id}) \n"
    reviewer_text = "レビュワー: #{reviewer.nickname}さん \n"
    pull_request_url_text = "url: #{url} \n"
    text = "#{mention_text}#{reviewer_text}#{pull_request_url_text}#{message}"
    mattermost_channel = group.mattermost_channel_id
    Notification::Mattermost.new(message: text, mattermost_channel:).call
  end

  private

  def set_reviewer
    self.reviewer = reviewer.presence || group.user_order_by_reviewer_amount(reviewee.id)
  end

  def set_message
    self.message = message.presence || 'レビューお願いします！'
  end
end
