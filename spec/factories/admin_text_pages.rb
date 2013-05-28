# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin_text_page, :class => 'Admin::TextPage' do
    page_type 1
    name "MyString"
  end
end
