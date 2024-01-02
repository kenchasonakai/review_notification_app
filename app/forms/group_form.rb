class GroupForm
  include ActiveModel::Model
  attr_accessor :name, :mattermost_channel_id, :group_member_ids, :group

  def initialize(params = {})
    @group = params[:group]
    @name = params[:name]
    @mattermost_channel_id = params[:mattermost_channel_id]
    @group_member_ids = params[:group_member_ids]
  end

  def save
    ActiveRecord::Base.transaction do
      group = Group.create!(name:, mattermost_channel_id:)
      group_member_ids&.each { |group_member_id| group.group_members.create!(user_id: group_member_id) }
    end
    true
  rescue ActiveRecord::RecordInvalid => e
    errors.add(:base, e.message)
    false
  end

  def update
    ActiveRecord::Base.transaction do
      group.update!(name:, mattermost_channel_id:)
      group.group_members.destroy_all
      group_member_ids&.each { |group_member_id| group.group_members.create!(user_id: group_member_id) }
    end
    true
  rescue ActiveRecord::RecordInvalid => e
    errors.add(:base, e.message)
    false
  end
end
