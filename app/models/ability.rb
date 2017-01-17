class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities

    user ||= User.new # guest user (not logged in)

    if user.role? :pupil
      # Pupils can only edit their own profiles
      can [:new, :create], Profile
      can [:index, :show, :edit, :update, :destroy], Profile, user: { id: user.id }
      # Pupils can only edit their own applications
      if user.profile.present?
        can [:new, :create], ApplicationLetter
      end
      can [:index, :show, :edit, :update, :destroy, :check], ApplicationLetter, user: { id: user.id }
      # Pupils can upload their letters of agreement
      can [:create], AgreementLetter
      can [:new, :create], Request
      cannot :view_personal_details, ApplicationLetter, user: { id: !user.id }
    end
    if user.role? :coach
      # Coaches can view Applications and participants for and view, upload and download materials for Event
      can [:view_applicants, :view_participants, :view_material, :upload_material, :print_applications, :download_material], Event
      can [:view_and_add_notes, :show], ApplicationLetter
      can [:print_applications], Event
      can :manage, Request
      cannot :check, ApplicationLetter
    end
    if user.role? :organizer
      can [:index, :show], Profile
      can [:index, :show, :view_and_add_notes, :update_status], ApplicationLetter
      cannot :update, ApplicationLetter
      # Organizers can view, edit and print Applications, view participants for, view, upload and download materials for, print agreement letters for and manage Events
      can [:view_applicants, :edit_applicants, :view_participants, :print_applications, :manage, :view_material, :upload_material, :print_agreement_letters, :download_material], Event
      can :manage, Request
      can [:update], ParticipantGroup
    end
    if user.role? :admin
      can :manage, :all
    end
  end
end
