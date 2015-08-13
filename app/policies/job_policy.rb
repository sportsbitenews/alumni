class JobPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def new?
    !user.nil?
  end

  def show?
    true
  end
  def create?
    !user.nil?
  end
end
