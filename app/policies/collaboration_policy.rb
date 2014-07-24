class CollaborationPolicy < ApplicationPolicy

  def create?
    user.account_type?(:plan_id)
  end

end