require 'spec_helper'

describe "admin/text_pages/new" do
  before(:each) do
    assign(:admin_text_page, stub_model(Admin::TextPage,
      :page_type => 1,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new admin_text_page form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", admin_text_pages_path, "post" do
      assert_select "input#admin_text_page_page_type[name=?]", "admin_text_page[page_type]"
      assert_select "input#admin_text_page_name[name=?]", "admin_text_page[name]"
    end
  end
end
