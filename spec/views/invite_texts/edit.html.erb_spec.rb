require 'spec_helper'

describe "invite_texts/edit" do
  before(:each) do
    @invite_text = assign(:invite_text, stub_model(InviteText,
      :title => "MyString",
      :content => "MyString",
      :story_type => 1
    ))
  end

  it "renders the edit invite_text form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", invite_text_path(@invite_text), "post" do
      assert_select "input#invite_text_title[name=?]", "invite_text[title]"
      assert_select "input#invite_text_content[name=?]", "invite_text[content]"
      assert_select "input#invite_text_story_type[name=?]", "invite_text[story_type]"
    end
  end
end
