require 'spec_helper'

describe "invite_texts/show" do
  before(:each) do
    @invite_text = assign(:invite_text, stub_model(InviteText,
      :title => "Title",
      :content => "Content",
      :story_type => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/Content/)
    rendered.should match(/1/)
  end
end
