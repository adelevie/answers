module AnswersGem

  class Ability
    include CanCan::Ability

    def initialize(user)

      @q_and_a = [Question, Answer]

      can :read, :all
      can :manage, user

      if user.is_admin
        can :manage, :all
      end

      if user.is_editor
        can :manage, @q_and_a
      end

      if user.is_writer
        can :create, @q_and_a
        # can [:update, :destroy], @q_and_a, status: "Draft", user_id: user.id
        # can [:update, :destroy], @q_and_a, guide: { user_id: user.id, status: "Draft" }
      end

    end
  end

end
