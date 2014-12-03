# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :access do
    user_id 1
    use_case_id 1
    add false
    edit false
    view false
    delete false
  end
end
