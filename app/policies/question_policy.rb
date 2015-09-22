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
    user ? record.user.id == user.id || user.admin? : false
  end

  def show?
    true
  end

  def create?
    !user.nil?
  end
end
