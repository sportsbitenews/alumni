class QuestionPolicy < PostPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end
end
