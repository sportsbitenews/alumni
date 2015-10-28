class QuestionPolicy < PostPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def new?
    !user.nil?
  end

  def update?
    admin_or_owner
  end

  def solve?
    admin_or_owner
  end

  def show?
    true
  end

  def create?
    !user.nil?
  end

  private

  def admin_or_owner
    user ? record.user.id == user.id || user.admin? : false
  end
end
