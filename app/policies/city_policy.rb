class CityPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def show?
    user.admin || user.cities.include?(record)
  end
end
