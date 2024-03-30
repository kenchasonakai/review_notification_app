class GroupMemberPolicy < ApplicationPolicy
  attr_reader :user, :group_member

  def new?
    create?
  end

  def create?
    @user.activated?
  end

  def destroy?
    @user.activated? && @user == @record.user
  end
end
