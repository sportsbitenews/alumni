class TestimonialPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    user_is_admin_or_manager?
  end

  def update?
    user_is_admin_or_manager?
  end

  private

  def user_is_admin_or_manager?
    user.admin || user.cities.include?(record.user.batch.city)
  end
end
