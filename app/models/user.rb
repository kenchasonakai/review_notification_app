class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  enum role: { general: 0, admin: 1 }

  validates :nickname, presence: true, on: :account_setup
  validates :mattermost_id, presence: true, on: :account_setup

  has_many :review_requests, dependent: :destroy, foreign_key: :reviewee_id, class_name: 'ReviewRequest',
                             inverse_of: :reviewee
  has_many :reviewer_requests, dependent: :destroy, foreign_key: :reviewer_id, class_name: 'ReviewRequest',
                               inverse_of: :reviewer
  has_many :group_members, dependent: :destroy
  has_many :groups, through: :group_members

  scope :activated, -> { where(activated: true) }
  scope :prioritize_unjoined_group, -> { left_joins(:group_members).group(:id).order('COUNT(group_members.id) ASC') }

  def profile_setup?
    nickname.present? && mattermost_id.present?
  end

  def joined_any_group?
    groups.present?
  end
end
