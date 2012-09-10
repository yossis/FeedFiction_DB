require 'spec_helper'

describe User do
  describe "likes" do
    before :all do
      @story = Story.create
      @user = User.create(name: 'yossi', email: 'yossi@feedfiction.com')
    end

    it "should be able to do like" do
      @user.like!(@story.id)
      @user.like?(@story.id).should be_true
    end

    it "should be able to do unlike" do
      @user.like!(@story.id)
      @user.unlike!(@story.id)
      @user.like?(@story.id).should be_false
    end

  end
end
