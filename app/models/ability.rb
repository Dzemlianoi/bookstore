class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :read, Book
    can :read, Category
    can :index, Review
    can [:create, :show], Coupon
    can [:index, :update, :create, :destroy], OrderItem, order: user.orders.last
    can [:create, :update, :confirm], Order, user: user

    if user.is_admin?
      can :manage, :all
    elsif !user.is_guest?
      can [:create, :index], Review
      can [:read, :create, :update,], Address, addressable_type: 'User', addressable_id: user.id
      can [:read, :create, :update, :update], Order, user: user
    end
  end
end
