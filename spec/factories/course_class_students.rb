# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :course_class_student do
    student_id ""
    course_class_id ""
    note "MyString"
  end
end
