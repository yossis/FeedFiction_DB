require "spec_helper"

describe Admin::TextPagesController do
  describe "routing" do

    it "routes to #index" do
      get("/admin/text_pages").should route_to("admin/text_pages#index")
    end

    it "routes to #new" do
      get("/admin/text_pages/new").should route_to("admin/text_pages#new")
    end

    it "routes to #show" do
      get("/admin/text_pages/1").should route_to("admin/text_pages#show", :id => "1")
    end

    it "routes to #edit" do
      get("/admin/text_pages/1/edit").should route_to("admin/text_pages#edit", :id => "1")
    end

    it "routes to #create" do
      post("/admin/text_pages").should route_to("admin/text_pages#create")
    end

    it "routes to #update" do
      put("/admin/text_pages/1").should route_to("admin/text_pages#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/admin/text_pages/1").should route_to("admin/text_pages#destroy", :id => "1")
    end

  end
end
