require 'spec_helper'

describe "image_types/new" do
  before(:each) do
    assign(:image_type, stub_model(ImageType,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new image_type form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => image_types_path, :method => "post" do
      assert_select "input#image_type_name", :name => "image_type[name]"
    end
  end
end
