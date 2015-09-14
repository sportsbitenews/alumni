class PostPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def show?
    true
  end

  def update?
    record.user.id == user.id || user.admin?
  end

  def up_vote?
    !user.nil?
  end
end
