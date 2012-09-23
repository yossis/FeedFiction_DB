require 'spec_helper'

describe "flags/show" do
  before(:each) do
    @flag = assign(:flag, stub_model(Flag,
      :story_id => 1,
      :flag_reason_id => 2,
      :reason => "Reason",
      :reporter_user_id => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/Reason/)
    rendered.should match(/3/)
  end
end
