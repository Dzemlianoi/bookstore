class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    case user.role_name
      when 'admin'
        can :manage, :all
      else
        can :read, :all
    end
  end
end
