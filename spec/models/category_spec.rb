require 'spec_helper'

describe Category do
  # it "saves itself" do
  #   category = Category.new(name: 'comedies')
  #   category.save
  #   expect(Category.first).to eq(category)
  # end
    
  # it "has many videos" do
  #   comedies = Category.create(name: 'comedies')
  #   south_park = Video.create(title: 'South Park', description: 'funny video', category: comedies)
  #   futurama = Video.create(title: 'Futurama', description: 'space travel', category: comedies)
  #   #expect(comedies.videos).to include(south_park, futurama)
  #   expect(comedies.videos).to eq([futurama, south_park])
  #end
  
  it { is_expected.to have_many(:videos) }
  it { is_expected.to validate_presence_of(:name) }
  
  describe "#recent_videos" do
    it "returns the videos in the reverse chronical order by created_at" do
      comedies = Category.create(name: 'comedies')
      futurama = Video.create(title: 'Futurama', description: 'space travel', category: comedies, created_at: 1.day.ago)
      south_park = Video.create(title: 'South Park', description: 'crazy kids', category: comedies)
      expect(comedies.recent_videos).to eq([south_park, futurama])
    end
    it "returns all videos if there are less than 6 videos" do
      comedies = Category.create(name: 'comedies')
      futurama = Video.create(title: 'Futurama', description: 'space travel', category: comedies, created_at: 1.day.ago)
      south_park = Video.create(title: 'South Park', description: 'crazy kids', category: comedies)
      expect(comedies.recent_videos.count).to eq(2)
    end
    it "returns 6 videos if there are more than 6 videos in the category" do
      comedies = Category.create(name: 'comedies')
      7.times {Video.create(title: 'foo', description: 'bar', category: comedies)}
      expect(comedies.recent_videos.count).to eq(6)
    end
    it "returns the most recent 6 videos" do
      comedies = Category.create(name: 'comedies')
      6.times {Video.create(title: 'foo', description: 'bar', category: comedies)}
      tonight_show = Video.create(title: 'Tonight Show', description: 'talk show', category: comedies, created_at: 1.day.ago)
      expect(comedies.recent_videos).not_to include(tonight_show)
    end
    it "return an empty array if there are no videos in the category" do
      comedies = Category.create(name: 'comedies')
      expect(comedies.recent_videos).to eq([])
    end
  end
end