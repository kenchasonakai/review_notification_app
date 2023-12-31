class ReviewRequest < ApplicationRecord
  belongs_to :reviewer, class_name: 'User'
  belongs_to :reviewee, class_name: 'User'

  validates :url, presence: true
  validates :message, presence: true

  before_validation :set_reviewer, on: :create
  before_validation :set_message, on: :create

  def notify
    text = "@#{reviewee.mattermost_id} @#{reviewer.mattermost_id} \n#{url} \n#{message}"
    # TODO: Groupを作成する時にGroupのチャンネルIDを取得するように変更する
    channel = 'c016s84r344'
    Notification::Mattermost.new(message: text, channel:).call
  end

  private

  def set_reviewer
    self.reviewer = reviewer.presence || User.where.not(id: reviewee_id).sample
  end

  def set_message
    self.message = message.presence || 'レビューお願いします！'
  end
end
