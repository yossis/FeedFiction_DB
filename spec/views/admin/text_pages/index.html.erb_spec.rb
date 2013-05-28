require 'spec_helper'

describe "admin/text_pages/index" do
  before(:each) do
    assign(:admin_text_pages, [
      stub_model(Admin::TextPage,
        :page_type => 1,
        :name => "Name"
      ),
      stub_model(Admin::TextPage,
        :page_type => 1,
        :name => "Name"
      )
    ])
  end

  it "renders a list of admin/text_pages" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
