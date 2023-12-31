class ReviewRequestsController < ApplicationController
  before_action :check_user_profile, only: %i[new create]

  def index
    @review_requests = ReviewRequest.includes(:reviewer, :reviewee).order(created_at: :desc)
  end

  def new
    @review_request = current_user.review_requests.build
  end

  def create
    @review_request = current_user.review_requests.build(review_request_params)
    if @review_request.save
      @review_request.notify
      redirect_to review_requests_path, notice: 'レビュー依頼を作成しました'
    else
      render :new
    end
  end

  private

  def review_request_params
    params.require(:review_request).permit(:url, :message)
  end

  def check_user_profile
    return if current_user.profile_setup?

    flash[:notice] = 'プロフィールを設定してください'
    redirect_to edit_profile_path
  end
end
