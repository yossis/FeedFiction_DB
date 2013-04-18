require 'spec_helper'

describe "InviteTexts" do
  describe "GET /invite_texts" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get invite_texts_path
      response.status.should be(200)
    end
  end
end
