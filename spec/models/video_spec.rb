require 'spec_helper'

describe Video do
  # it "saves itself" do
  #   video = Video.new(title: 'Monk', description: 'great video')
  #   video.save
  #   expect(Video.first).to eq(video)
  #   #Video.first.should == video
  #   #Video.first.should eq(video)
  # end
  
  # it "belongs to category" do
  #   dramas = Category.create(name: 'dramas')
  #   monk = Video.create(title: 'Monk', description: 'a great video', category: dramas)
  #   expect(monk.category).to eq(dramas)
  # end
  
  # it "does not save a video without a title" do
  #   video = Video.create(description: 'a great video')
  #   expect(Video.count).to eq(0)
  # end
  
  # it "does not save a video without a description" do
  #   video = Video.create(title: 'Monk')
  #   expect(Video.count).to eq(0)
  # end
  
  it { should belong_to(:category) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should have_many(:reviews).order("created_at DESC") }
  
  describe "search_by_title" do
    it "returns an empty array if there is no match" do
      futurama = Video.create(title: 'Futurama', description: 'space travel')
      back_to_future = Video.create(title: 'Back to Future', description: 'time travel')
      expect(Video.search_by_title("hello")).to eq([])
    end
    it "returns an array of one video for the exact match" do
      futurama = Video.create(title: 'Futurama', description: 'space travel')
      back_to_future = Video.create(title: 'Back to Future', description: 'time travel')
      expect(Video.search_by_title("Futurama")).to eq([futurama])
    end
    it "returns an array of one video for a partial match" do
      futurama = Video.create(title: 'Futurama', description: 'space travel')
      back_to_future = Video.create(title: 'Back to Future', description: 'time travel')
      expect(Video.search_by_title("urama")).to eq([futurama])
    end
    it "returns an array of all matches ordered by created_at" do
      futurama = Video.create(title: 'Futurama', description: 'space travel', created_at: 1.day.ago)
      back_to_future = Video.create(title: 'Back to Future', description: 'time travel')
      expect(Video.search_by_title("Futur")).to eq([back_to_future, futurama])
    end
    it "returns an empty array for a search with an empty string" do
      futurama = Video.create(title: 'Futurama', description: 'space travel')
      back_to_future = Video.create(title: 'Back to Future', description: 'time travel')
      expect(Video.search_by_title("")).to eq([])
    end
  end
end