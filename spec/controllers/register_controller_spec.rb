require 'spec_helper'

describe RegisterController do

  describe "GET 'start'" do
    it "returns http success" do
      get 'start'
      response.should be_success
    end
  end

  describe "GET 'friends'" do
    it "returns http success" do
      get 'friends'
      response.should be_success
    end
  end

end
