class OauthsController < ApplicationController
  skip_before_action :require_login
  skip_after_action :verify_authorized
  after_action :auto_activate, only: :callback

  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    @user = login_from(provider)
    if @user
      update_user_info(provider)
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

  def update_user_info(provider)
    sorcery_fetch_user_hash(provider)
    github_id = @user_hash.dig(:user_info, 'login')
    return if github_id.blank?
    return if @user.github_id == github_id

    @user.update(github_id:)
  end

  def auto_activate
    return if @user.blank? || @user.activated?

    client = Octokit::Client.new(access_token: Rails.application.credentials.dig(:github, :access_token))
    @user.activate! if client.org_member?('runteq', @user.github_id)
  end
end
