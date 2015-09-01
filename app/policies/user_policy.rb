class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def show?
    true
  end

  def confirm?
    user.admin
  end

  def delete?
    user.admin
  end

  def update?
    record == user
  end
end
