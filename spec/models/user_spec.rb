# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  provider         :string(255)
#  uid              :string(255)
#  name             :string(255)
#  nick_name        :string(255)
#  avatar           :string(255)
#  email            :string(255)
#  gender           :string(255)
#  oauth_token      :string(255)
#  oauth_expires_at :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  login_count      :integer          default(0)
#  big_avatar       :string(255)
#  cover            :string(255)
#

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
