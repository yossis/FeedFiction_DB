require "spec_helper"

describe InviteTextsController do
  describe "routing" do

    it "routes to #index" do
      get("/invite_texts").should route_to("invite_texts#index")
    end

    it "routes to #new" do
      get("/invite_texts/new").should route_to("invite_texts#new")
    end

    it "routes to #show" do
      get("/invite_texts/1").should route_to("invite_texts#show", :id => "1")
    end

    it "routes to #edit" do
      get("/invite_texts/1/edit").should route_to("invite_texts#edit", :id => "1")
    end

    it "routes to #create" do
      post("/invite_texts").should route_to("invite_texts#create")
    end

    it "routes to #update" do
      put("/invite_texts/1").should route_to("invite_texts#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/invite_texts/1").should route_to("invite_texts#destroy", :id => "1")
    end

  end
end
