require 'spec_helper'

describe "admin/statuses/edit" do
  before(:each) do
    @admin_statu = assign(:admin_statu, stub_model(Admin::Status,
      :name => "MyString"
    ))
  end

  it "renders the edit admin_statu form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => admin_statuses_path(@admin_statu), :method => "post" do
      assert_select "input#admin_statu_name", :name => "admin_statu[name]"
    end
  end
end
