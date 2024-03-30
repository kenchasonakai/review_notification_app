class ProfilesController < ApplicationController
  # NOTE: current_userで取得したユーザーのみを対象とするため、authorizeメソッドをスキップする
  skip_after_action :verify_authorized, only: %i[show edit update destroy]

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

  def destroy
    current_user.destroy!
    redirect_to root_path, notice: 'アカウントを削除しました。'
  end

  private

  def user_params
    params.require(:user).permit(:nickname)
  end
end
