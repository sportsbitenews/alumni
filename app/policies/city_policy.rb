class CityPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    user_is_manager_or_admin?
  end

  def update?
    user_is_manager_or_admin?
  end

  def markdown_preview?
    user_is_manager_or_admin?
  end

  def set_manager?
    user_is_manager_or_admin?
  end

  private

  def user_is_manager_or_admin?
    user.admin || user.cities.include?(record)
  end
end
