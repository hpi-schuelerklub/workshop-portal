# == Schema Information
#
# Table name: application_letters
#
#  id          :integer          not null, primary key
#  motivation  :string
#  user_id     :integer          not null
#  workshop_id :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :application_letter do
    grade 10
    experience "None"
    motivation "None"
    coding_skills "None"
    emergency_number "01234567891"
    vegeterian false
    vegan false
    allergic true
    allergies "Many"
    user
    workshop
  end
end
