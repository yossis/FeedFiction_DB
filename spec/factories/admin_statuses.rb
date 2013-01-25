# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin_status, :class => 'Admin::Status' do
    name "MyString"
  end
end
