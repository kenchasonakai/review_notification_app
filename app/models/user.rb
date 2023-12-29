class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications
  enum role: { general: 0, admin: 1 }

  validates :nickname, presence: true, on: :account_setup
  validates :mattermost_id, presence: true, on: :account_setup
end
