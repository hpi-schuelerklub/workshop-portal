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

    # Even guests can see the apply button
    # This is revoked for coaches and organizers below.
    can %i[view_apply_button], Event
    can %i[show index archive], Event

    if user.role? :pupil
      # Pupils can only edit their own profiles
      can %i[new create], Profile
      can %i[index show edit update destroy], Profile, user: { id: user.id }
      # Pupils can only edit their own applications
      can %i[new create], ApplicationLetter if user.profile.present?
      can %i[index show edit update check destroy view_personal_details], ApplicationLetter, user: { id: user.id }
      # Pupils can upload their letters of agreement
      can %i[create], AgreementLetter
      can %i[new create], Request

    elsif user.role? :coach
      # Coaches can only edit their own profiles
      can %i[new create], Profile
      can %i[index show edit update destroy], Profile, user: { id: user.id }

      # Coaches can view Applications and participants for and view, upload and download materials for Event
      can %i[view_applicants view_participants view_material upload_material print_applications download_material], Event
      can %i[view_and_add_notes show], ApplicationLetter
      can %i[show index], Request
      cannot %i[apply view_apply_button], Event

    elsif user.role? :organizer
      # Organizers can only edit their own profiles
      can %i[new create index show], Profile
      can %i[edit update destroy], Profile, user: { id: user.id }
      can %i[manage set_contact_person set_notes show index], Request
      can %i[index show view_and_add_notes update_status], ApplicationLetter
      can %i[manage view_applicants edit_applicants view_participants print_applications view_material
             upload_material print_agreement_letters download_material view_unpublished show_eating_habits
             print_applications_eating_habits view_hidden edit update destroy], Event
      cannot %i[apply view_apply_button], Event
      can %i[send_email], Email
      can %i[update], ParticipantGroup

      # Organizers can update user roles of pupil, coach and organizer, but cannot manage admins and cannot update a role to admin
      can %i[manage], User, role: %w[pupil coach organizer]
      cannot %i[update_role], User, role: 'admin'
      cannot %i[update_role_to_admin], User

    elsif user.role? :admin
      can %i[manage], :all
      cannot %i[edit update], ApplicationLetter
    end
  end
end
