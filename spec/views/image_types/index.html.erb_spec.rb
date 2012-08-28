require 'spec_helper'

describe "image_types/index" do
  before(:each) do
    assign(:image_types, [
      stub_model(ImageType,
        :name => "Name"
      ),
      stub_model(ImageType,
        :name => "Name"
      )
    ])
  end

  it "renders a list of image_types" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
