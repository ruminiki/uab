# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :employee do
    name "MyString"
    phone_number "MyString"
    rg "MyString"
    cpf "MyString"
    birthday "2014-11-18"
    employee_category_id 1
    city_id 1
    address "MyString"
    email "MyString"
  end
end
