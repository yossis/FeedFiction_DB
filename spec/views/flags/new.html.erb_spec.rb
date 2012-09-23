require 'spec_helper'

describe "flags/new" do
  before(:each) do
    assign(:flag, stub_model(Flag,
      :story_id => 1,
      :flag_reason_id => 1,
      :reason => "MyString",
      :reporter_user_id => 1
    ).as_new_record)
  end

  it "renders new flag form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => flags_path, :method => "post" do
      assert_select "input#flag_story_id", :name => "flag[story_id]"
      assert_select "input#flag_flag_reason_id", :name => "flag[flag_reason_id]"
      assert_select "input#flag_reason", :name => "flag[reason]"
      assert_select "input#flag_reporter_user_id", :name => "flag[reporter_user_id]"
    end
  end
end
