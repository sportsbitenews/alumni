class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def confirm?
    user.admin || (user.cities.any? && user.cities.include?(record.batch.city))
  end

  def delete?
    user.admin
  end

  def update?
    record == user
  end

  def offboarding?
    offboard?
  end

  def offboard?
    user.admin
  end

  def admin_update?
    user.admin || user.cities.any?
  end

  def impersonate?
    record.admin?
  end

  def stop_impersonating?
    impersonate?
  end
end
