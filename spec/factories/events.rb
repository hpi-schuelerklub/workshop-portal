# == Schema Information
#
# Table name: events
#
#  id               :integer          not null, primary key
#  name             :string
#  description      :string
#  max_participants :integer
#  date_ranges      :collection
#  published        :boolean
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

FactoryGirl.define do
  factory :event do
    name "Event-Name"
    description "Event-Description"
    max_participants 100
    active false
    organizer "Workshop-Organizer"
    knowledge_level "Workshop-Knowledge Level"
    date_ranges { build_list :date_range, 1 }

    trait :with_two_date_ranges do
      after(:build) do |event|
        event.date_ranges = []
        event.date_ranges << FactoryGirl.create(:date_range, start_date: Date.tomorrow, end_date: Date.tomorrow.next_day(5))
        event.date_ranges << FactoryGirl.create(:date_range, start_date: Date.tomorrow, end_date: Date.tomorrow.next_day(10))
      end
    end

    trait :with_multiple_date_ranges do
      after(:build) do |event|
        event.date_ranges = []
        event.date_ranges << FactoryGirl.create(:date_range, start_date: Date.today.next_day(3), end_date: Date.tomorrow.next_day(5))
        event.date_ranges << FactoryGirl.create(:date_range, start_date: Date.today.next_day(12), end_date: Date.today.next_day(16))
        event.date_ranges << FactoryGirl.create(:date_range, start_date: Date.today, end_date: Date.tomorrow)
      end
    end

    trait :with_unreasonably_long_range do
      after(:build) do |event|
        event.date_ranges << FactoryGirl.create(:date_range,
          start_date: Date.today,
          end_date: Date.tomorrow.next_day(Event::UNREASONABLY_LONG_DATE_SPAN))
      end
    end

    trait :without_date_ranges do
      date_ranges {}
    end
  end
end
