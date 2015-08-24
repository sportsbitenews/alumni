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
    record.project.map(&:users).flatten.uniq.include?(user)
  end

  def show?
    true
  end
end
