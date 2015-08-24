class MilestonePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def new?
    record.users.include? user
  end

  def create?
    !user.nil?
  end

  def show?
    true
  end
end
