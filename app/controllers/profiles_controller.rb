class ProfilesController < ApplicationController
  def show
    authorize current_user
  end

  def edit
    @user = User.find(current_user.id)
    authorize @user
  end

  def update
    @user = User.find(current_user.id)
    authorize @user
    @user.assign_attributes(user_params)
    if @user.save(context: :account_setup)
      redirect_to profile_path, notice: 'プロフィールを更新しました。'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :mattermost_id)
  end
end
