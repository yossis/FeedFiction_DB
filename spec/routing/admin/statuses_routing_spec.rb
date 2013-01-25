require "spec_helper"

describe Admin::StatusesController do
  describe "routing" do

    it "routes to #index" do
      get("/admin/statuses").should route_to("admin/statuses#index")
    end

    it "routes to #new" do
      get("/admin/statuses/new").should route_to("admin/statuses#new")
    end

    it "routes to #show" do
      get("/admin/statuses/1").should route_to("admin/statuses#show", :id => "1")
    end

    it "routes to #edit" do
      get("/admin/statuses/1/edit").should route_to("admin/statuses#edit", :id => "1")
    end

    it "routes to #create" do
      post("/admin/statuses").should route_to("admin/statuses#create")
    end

    it "routes to #update" do
      put("/admin/statuses/1").should route_to("admin/statuses#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/admin/statuses/1").should route_to("admin/statuses#destroy", :id => "1")
    end

  end
end
