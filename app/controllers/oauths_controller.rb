class OauthsController < ApplicationController
  skip_before_action :require_login

  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    @user = login_from(provider)
    if @user
      redirect_to root_path, notice: 'ログインしました'
    else
      create_user_from_provider(provider)
    end
  end

  private

  def auth_params
    params.permit(:code, :provider)
  end

  def create_user_from_provider(provider)
    @user = create_from(provider)

    reset_session
    auto_login(@user)
    redirect_to root_path, notice: 'ログインしました'
  rescue StandardError
    redirect_to root_path, alert: 'ログインに失敗しました'
  end
end
