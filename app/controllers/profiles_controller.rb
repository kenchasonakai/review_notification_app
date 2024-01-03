class ProfilesController < ApplicationController
  # NOTE: current_userで取得したユーザーのみを対象とするため、authorizeメソッドをスキップする
  skip_after_action :verify_authorized, only: %i[show edit update]

  def show; end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)
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
