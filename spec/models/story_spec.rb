# == Schema Information
#
# Table name: stories
#
#  id                   :integer          not null, primary key
#  user_id              :integer
#  image_id             :integer
#  is_complete          :boolean
#  inappropriate        :integer
#  quality              :integer
#  story_source_id      :integer
#  category_id          :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  last_line_updated_at :datetime
#  view_count           :integer          default(0)
#  status               :integer          default(1)
#  slug                 :string(255)
#

require 'spec_helper'

describe Story do 
	before { @story = Story.new }


subject { @story }

  it { should respond_to(:category_id) }
  it { should respond_to(:image_url) }

  describe "is not valid without a picture" do
    before { @story.image_url = "" }
    it { should_not be_valid }
  end

  describe "is valid with a picture" do
    before { @story.image_url = "http://a5.sphotos.ak.fbcdn.net/hphotos-ak-snc6/180516_10150096261404111_8292170_n.jpg" }
    it { should be_valid }
  end

  describe "it is not valid without a story line" do
	before {@story.image_url = "ht"}
    it { should_not be_valid }
  end

   describe "it is valid with a story line" do
  	before do
  		@storyLine = StoryLine.new
 		@storyLine.line = "eee"
 		@story.story_lines << @storyLine
 		@story.image_url = "ht"		
  	end	
    it { should be_valid }
  end

  describe 'image' do
    before :each do
      @image = mock
      @story.stub!(:image).and_return(@image)
      @story.stub!(:valid?).and_return(true)
    end

    it "should resize image after save" do
      @image.stub!(:image_processed?).and_return(false)
      @image.should_receive(:enqueue_image)
      @story.save!
    end

    it "should resize image after save" do
      @image.stub!(:image_processed?).and_return(true)
      @image.should_not_receive(:enqueue_image)
      @story.save!
    end
    
  end

end
