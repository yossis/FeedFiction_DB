require 'spec_helper'

describe "admin/statuses/index" do
  before(:each) do
    assign(:admin_statuses, [
      stub_model(Admin::Status,
        :name => "Name"
      ),
      stub_model(Admin::Status,
        :name => "Name"
      )
    ])
  end

  it "renders a list of admin/statuses" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
