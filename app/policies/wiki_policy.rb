class WikiPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def create?
    user.present? || user.role?(:admin)
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end
  
  def update?
    create?
  end
end