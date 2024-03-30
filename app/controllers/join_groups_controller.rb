class JoinGroupsController < ApplicationController
  def new
    @groups = Group.all
    authorize :group_member, :new?
  end

  def create
    group = Group.find(params[:group_id])
    authorize :group_member, :create?
    group.users << current_user
    redirect_to new_join_groups_path
  end

  def destroy
    group = Group.find(params[:group_id])
    group_member = group.group_members.find_by(user: current_user)
    authorize group_member
    group.users.delete(current_user)
    redirect_to new_join_groups_path
  end
end
