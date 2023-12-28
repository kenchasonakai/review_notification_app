class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  validates :nickname, presence: true, on: :account_setup
  validates :mattermost_id, presence: true, on: :account_setup
end
