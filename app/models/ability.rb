class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.has_role? :admin
      can :manage, :all
    elsif user.has_role? :user
      can [:edit, :update], [User], id: user.id
      can [:update, :destroy], [Recipe], owner: user
      can :toggle_group, Group
      can :create, [Recipe]
      can :read, :all
    elsif user.has_role? :banned
      cannot :manage, :all
    else
      can :read, :all
    end
  end
end
