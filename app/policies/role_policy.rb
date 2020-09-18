class RolePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    raise
  end

  def new?
    record.job.user == user
  end
end

