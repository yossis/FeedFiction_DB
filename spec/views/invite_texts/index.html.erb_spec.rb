require 'spec_helper'

describe "invite_texts/index" do
  before(:each) do
    assign(:invite_texts, [
      stub_model(InviteText,
        :title => "Title",
        :content => "Content",
        :story_type => 1
      ),
      stub_model(InviteText,
        :title => "Title",
        :content => "Content",
        :story_type => 1
      )
    ])
  end

  it "renders a list of invite_texts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Content".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
