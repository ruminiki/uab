# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :course_class do
    name "MyString"
    institution_id 1
    course_id 1
    begin "2014-10-23"
  	end
  end
end
