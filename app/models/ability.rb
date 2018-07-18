class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.has_role? :admin
      can :manage, :all
    elsif user.has_role? :guest
      can :follow, Author
      can [:create, :destroy, :add_book_borrow], BookBorrow
      can :manage, Borrow
      can [:like, :follow], Book
      can :create, Comment
      can :show, User
    end
  end
end
