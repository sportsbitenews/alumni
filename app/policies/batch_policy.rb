class BatchPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def show?
    true
  end

  def update?
    admin_or_city_user?
  end

  def create?
    admin_or_city_user?
  end

  def onboarding?
    record.any?
  end

  def register?
    record.onboarding
  end

  private

  def admin_or_city_user?
    user.admin || record.city.users.include?(user)
  end
end
