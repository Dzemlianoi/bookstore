# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :read, Book
    can :read, Category
    can :index, Review
    can %i(create show), Coupon
    can %i(index update create destroy), OrderItem, order: user.orders.last
    can %i(create update confirm), Order, user: user

    if user.admin?
      can :manage, :all
    elsif !user.guest?
      can %i(create index), Review
      can %i(read create update), Address, addressable_type: 'User', addressable_id: user.id
      can %i(read create update destroy), Order, user: user
    end
  end
end
