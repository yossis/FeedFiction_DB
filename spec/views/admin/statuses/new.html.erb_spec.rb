require 'spec_helper'

describe "admin/statuses/new" do
  before(:each) do
    assign(:admin_statu, stub_model(Admin::Status,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new admin_statu form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => admin_statuses_path, :method => "post" do
      assert_select "input#admin_statu_name", :name => "admin_statu[name]"
    end
  end
end
