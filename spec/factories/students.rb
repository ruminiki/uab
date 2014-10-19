# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :student do
    name "MyString"
    phone_number "MyString"
    email "MyString"
    has_badge false
    badge_observation "MyString"
    birthday "2014-10-18"
    address "MyString"
  end
end
