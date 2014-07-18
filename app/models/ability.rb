class Ability 
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.plan_id == "1"
      can :create, Wiki, user_id: user.id
      can :edit, user.shared_wikis
    end

    if user.plan_id == "2"
      can :create, Wiki, user_id: user.id
      can :manage, Wiki, user_id: user.id
      can :edit, user.shared_wikis
      can :privatize, Wiki, user_id: user.id
    end

    if user.role? :moderator
      can :destroy, Wiki
    end

    if user.role? :administrator
      can :manage, :all
    end

    if user.role? :collaborator
      can :manage, Wiki, user_id: user.id
    end
     
  end
end
