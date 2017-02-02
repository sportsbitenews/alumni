class MilestonePolicy < PostPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def new?
    # user.projects.any?
    true
  end

  def update?
    user ? record.user_id == user.id || user.admin? : false
  end

  def create?
    record.project.users.include? user
  end

  def show?
    true
  end
end
