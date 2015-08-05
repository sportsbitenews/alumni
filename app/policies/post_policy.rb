class PostPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def new?
    !user.nil?
  end

  def up_vote?
    !user.nil?
  end
end
