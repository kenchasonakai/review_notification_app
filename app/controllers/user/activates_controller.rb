class User::ActivatesController < ApplicationController
  def create
    user = User.find(params[:user_id])
    authorize(user, :update?)
    user.update(activated: true)
    flash[:notice] = "#{user.nickname}をアクティベートしました"
    redirect_to users_path
  end

  def destroy
    user = User.find(params[:user_id])
    authorize user
    user.update(activated: false)
    flash[:notice] = "#{user.nickname}のアクティベートを解除しました"
    redirect_to users_path
  end
end
