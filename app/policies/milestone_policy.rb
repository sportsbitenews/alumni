class MilestonePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def new?
    user.projects.any?
  end

  def create?
    record.project.users.include? user
  end

  def show?
    true
  end
end
