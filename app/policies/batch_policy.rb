class BatchPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def show?
    true
  end

  def create?
    admin_or_city_user?
  end

  def update?
    admin_or_city_user?
  end

  def register?
    record.onboarding
  end

  def signing_sheet?
    admin_or_city_user?
  end

  private

  def admin_or_city_user?
    user.admin || user.cities.include?(record.city)
  end
end
