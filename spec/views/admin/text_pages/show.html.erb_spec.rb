require 'spec_helper'

describe "admin/text_pages/show" do
  before(:each) do
    @admin_text_page = assign(:admin_text_page, stub_model(Admin::TextPage,
      :page_type => 1,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Name/)
  end
end
