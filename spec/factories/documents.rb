# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :document do
    name "MyString"
    document_category_id 1
    path "MyString"
    extension "MyString"
    size "MyString"
  end
end
