require 'spec_helper'

describe CustomRegistrationsController do

  describe "GET 'create'" do
    it "returns http success" do
      get 'create'
      response.should be_success
    end
  end

  describe "GET 'story'" do
    it "returns http success" do
      get 'story'
      response.should be_success
    end
  end

end
