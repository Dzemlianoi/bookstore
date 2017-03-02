class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.is_admin?
      can :manage, :all
    elsif user.is_guest?
    # some code
    else
      can :read, Book
      can :read, Category
      can [:create, :index], Review
      can [:create, :update, :read], Address, addressable_type: 'User', addressable_id: user.id
      can [:create, :show], Coupon
      can [:index, :update, :create, :destroy], OrderItem, order: user.orders.last
      can [:index, :update, :create, :destroy], OrderItem, order: user.orders.last
      can [:read, :create, :update, :confirm], Order, user: user
    end
  end
end
