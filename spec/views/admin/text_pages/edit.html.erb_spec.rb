require 'spec_helper'

describe "admin/text_pages/edit" do
  before(:each) do
    @admin_text_page = assign(:admin_text_page, stub_model(Admin::TextPage,
      :page_type => 1,
      :name => "MyString"
    ))
  end

  it "renders the edit admin_text_page form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", admin_text_page_path(@admin_text_page), "post" do
      assert_select "input#admin_text_page_page_type[name=?]", "admin_text_page[page_type]"
      assert_select "input#admin_text_page_name[name=?]", "admin_text_page[name]"
    end
  end
end
