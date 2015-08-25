class CityPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def show?
    user.admin || record.users.include?(user)
  end
end
