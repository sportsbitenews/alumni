class QuestionPolicy < PostPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def new?

  end

  def show?
    true
  end

  def create?
    !user.nil?
  end
end
