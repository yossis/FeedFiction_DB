require 'spec_helper'

describe ImportImagesController do

  describe "GET 'facebook'" do
    it "returns http success" do
      get 'facebook'
      response.should be_success
    end
  end

  describe "GET 'instagram'" do
    it "returns http success" do
      get 'instagram'
      response.should be_success
    end
  end

  describe "GET 'upload'" do
    it "returns http success" do
      get 'upload'
      response.should be_success
    end
  end

end
