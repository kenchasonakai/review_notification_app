class ReviewRequestPolicy < ApplicationPolicy
  attr_reader :user, :review_request

  def initialize(user, review_request)
    @user = user
    @review_request = review_request
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.admin? || user.activated?
  end

  def new?
    create?
  end

  def update?
    user.admin? || user.activated? && user == review_request.user
  end

  def edit?
    update?
  end

  def destroy?
    user.admin?
  end
end
