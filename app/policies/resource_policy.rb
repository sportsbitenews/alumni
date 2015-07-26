class ResourcePolicy < PostPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    !user.nil?
  end

  def preview?
    !user.nil?
  end
end
