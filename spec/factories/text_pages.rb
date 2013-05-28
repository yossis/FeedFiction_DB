# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :text_page do
    page_type 1
    name "MyString"
  end
end
