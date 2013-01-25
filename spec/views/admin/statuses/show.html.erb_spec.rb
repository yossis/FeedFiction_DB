require 'spec_helper'

describe "admin/statuses/show" do
  before(:each) do
    @admin_statu = assign(:admin_statu, stub_model(Admin::Status,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
