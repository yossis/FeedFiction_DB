require 'spec_helper'

describe "flags/index" do
  before(:each) do
    assign(:flags, [
      stub_model(Flag,
        :story_id => 1,
        :flag_reason_id => 2,
        :reason => "Reason",
        :reporter_user_id => 3
      ),
      stub_model(Flag,
        :story_id => 1,
        :flag_reason_id => 2,
        :reason => "Reason",
        :reporter_user_id => 3
      )
    ])
  end

  it "renders a list of flags" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Reason".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
