class OrderedListPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def update?
    user_is_manager_or_admin?
  end

  private

  def user_is_manager_or_admin?
    user.admin || user.cities.map(&:slug).include?(record.name.match(/([a-z]+)/)[1])
  end
end
