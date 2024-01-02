class Group < ApplicationRecord
  has_many :group_members, dependent: :destroy
  has_many :users, through: :group_members

  def added_at(user)
    group_members.find_by(user:).created_at
  end
end
