# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :invite_text do
    title "MyString"
    content "MyString"
    story_type 1
  end
end
