require 'spec_helper'

describe "image_types/show" do
  before(:each) do
    @image_type = assign(:image_type, stub_model(ImageType,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
