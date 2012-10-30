require 'spec_helper'

describe ImagesController do
  context "upload" do
    before :each do
      controller.stub!(:current_user).and_return(double(id: 4))
      ImageType.should_receive(:upload_id).and_return(1)
    end

    it "creates a new image object" do
      image = Image.new
      Image.should_receive(:new).twice.and_return(image)
      image.should_receive(:save)

      post :create, key: "12435345563", format: :js
    end

    it "saves the corrent data in the image object" do
      image = Image.new
      Image.stub!(:new).and_return(image)
      image.stub!(:save)

      post :create, key: "key", format: :js
      image.image_source.should == "key"
    end

  end
end