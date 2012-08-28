require "spec_helper"

describe ImageTypesController do
  describe "routing" do

    it "routes to #index" do
      get("/image_types").should route_to("image_types#index")
    end

    it "routes to #new" do
      get("/image_types/new").should route_to("image_types#new")
    end

    it "routes to #show" do
      get("/image_types/1").should route_to("image_types#show", :id => "1")
    end

    it "routes to #edit" do
      get("/image_types/1/edit").should route_to("image_types#edit", :id => "1")
    end

    it "routes to #create" do
      post("/image_types").should route_to("image_types#create")
    end

    it "routes to #update" do
      put("/image_types/1").should route_to("image_types#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/image_types/1").should route_to("image_types#destroy", :id => "1")
    end

  end
end
