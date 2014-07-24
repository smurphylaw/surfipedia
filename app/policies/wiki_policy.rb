class WikiPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def create?
    user.present? || user.role?(:admin)
  end
  
  def update?
     user.present?
  end
 
  def collaborators?
     update_collaborators?
  end
   
  def update_collaborators?
      update?
  end

  def edit?
    create?
  end
  
  def make_private?
    user.present?
  end
end