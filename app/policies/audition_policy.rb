class AuditionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def new?
    return true
  end

  def create?
    return true
  end

  def approve?
    return true
  end

  def reject?
    return true
  end
end
