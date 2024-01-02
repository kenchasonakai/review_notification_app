class UserPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    raise Pundit::NotAuthorizedError, 'must be logged in' unless user
    @user = user
    @record = record
  end

  def index?
    user.admin?
  end

  def show?
    user == record
  end

  def update?
    user == record
  end

  def edit?
    update?
  end

  def destroy?
    user == record
  end
end
