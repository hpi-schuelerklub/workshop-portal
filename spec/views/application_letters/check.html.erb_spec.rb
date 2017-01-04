require 'rails_helper'

RSpec.describe "application_letters/check", type: :view do
  before(:each) do
    @application_letter = assign(:application_letter, FactoryGirl.create(:application_letter))
    @application_letter.user.profile = FactoryGirl.build(:profile)
    render
  end

  it "has correct headline" do
    expect(rendered).to have_css('h1', text: I18n.t('application_letters.check.check_application_for', event_name: @application_letter.event.name))
  end

  it "renders information concerning application deadline" do
    expect(rendered).to have_text(I18n.t('application_letters.check.can_change_until', application_deadline: I18n.l(@application_letter.event.application_deadline)))
  end

  it "renders application's attributes" do
    expect(rendered).to have_css('h3', text: I18n.t('application_letters.check.my_application'))
    expect(rendered).to have_text(@application_letter.grade)
    expect(rendered).to have_text(@application_letter.experience)
    expect(rendered).to have_text(@application_letter.motivation)
    expect(rendered).to have_text(@application_letter.coding_skills)
    expect(rendered).to have_text(@application_letter.emergency_number)
    expect(rendered).to have_text(@application_letter.allergies)
    #TODO vegetarian etc
  end

  it "renders applicant's attributes" do
    expect(rendered).to have_css('h3', text: I18n.t('application_letters.check.my_personal_data'))
    expect(rendered).to have_text(@application_letter.user.profile.name)
    expect(rendered).to have_text(@application_letter.user.profile.gender)
    expect(rendered).to have_text(@application_letter.user.profile.age)
    expect(rendered).to have_text(@application_letter.user.profile.school)
    expect(rendered).to have_text(@application_letter.user.profile.address)
    expect(rendered).to have_text(@application_letter.user.profile.graduates_school_in)
  end

  it "renders button to edit application" do
    expect(rendered).to have_link(id: 'edit_application_link', href: edit_application_letter_path(@application_letter))
  end

  it "renders button to edit profile" do
    expect(rendered).to have_link(id: 'edit_profile_link', href: edit_profile_path(@application_letter.user.profile))
  end

end
