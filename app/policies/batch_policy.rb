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
    user.admin
  end

  def create?
    user.admin
  end

  def register?
    record.onboarding
  end

  def signing_sheet?
    admin_or_city_user?
  end

  private

  def admin_or_city_user?
    user.admin || record.city.users.include?(user)
  end
end
