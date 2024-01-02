class UserPolicy < ApplicationPolicy
  attr_reader :user, :record

  def index?
    user.admin?
  end

  def show?
    user.admin? || user == record
  end

  def update?
    user.admin? || user == record
  end

  def edit?
    update?
  end

  def destroy?
    user.admin?
  end
end
