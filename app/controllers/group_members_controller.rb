class GroupMembersController < ApplicationController
  def create
    group = Group.find(params[:group_id])
    authorize(group, :update?)
    user = User.find(params[:user_id])
    group.users << user
    redirect_to groups_path, notice: "#{user.nickname}を#{group.name}に追加しました。"
  end

  def destroy
    group = Group.find(params[:group_id])
    authorize(group, :update?)
    user = User.find(params[:id])
    group.users.destroy(user)
    redirect_to groups_path, notice: "#{user.nickname}を#{group.name}から外しました。"
  end
end
