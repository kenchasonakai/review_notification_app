class UserPolicy < ApplicationPolicy
  attr_reader :user, :record

  def index?
    user.admin?
  end

  def show?
    user.admin?
  end

  def update?
    user.admin?
  end

  def edit?
    update?
  end

  def destroy?
    user.admin?
  end
end
