class AnswerPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def update?
    record.user.id == user.id
  end
end
