class ReviewRequestsController < ApplicationController
  before_action :check_user_profile, only: %i[new create]
  before_action :check_joined_any_group, only: %i[new create]

  def index
    @review_requests = ReviewRequest.includes(:reviewer, :reviewee).order(created_at: :desc)
    authorize @review_requests
  end

  def new
    @review_request = current_user.review_requests.build
    authorize @review_request
  end

  def create
    @review_request = current_user.review_requests.build(review_request_params)
    authorize @review_request
    if @review_request.save
      @review_request.notify
      redirect_to review_requests_path, notice: 'レビュー依頼を作成しました'
    else
      flash.now[:alert] = 'レビュー依頼が出来ませんでした'
      render :new, status: :unprocessable_entity
    end
  end

  private

  def review_request_params
    params.require(:review_request).permit(:url, :message).merge(group: current_user.group)
  end

  def check_user_profile
    return if current_user.profile_setup?

    flash[:notice] = 'プロフィールを設定してください'
    redirect_to edit_profile_path
  end

  def check_joined_any_group
    return if current_user.joined_any_group?

    flash[:notice] = 'グループに参加していません'
    redirect_to review_requests_path
  end
end
