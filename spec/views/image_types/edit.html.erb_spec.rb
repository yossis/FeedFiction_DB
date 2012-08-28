require 'spec_helper'

describe "image_types/edit" do
  before(:each) do
    @image_type = assign(:image_type, stub_model(ImageType,
      :name => "MyString"
    ))
  end

  it "renders the edit image_type form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => image_types_path(@image_type), :method => "post" do
      assert_select "input#image_type_name", :name => "image_type[name]"
    end
  end
end
