require "spec_helper"

describe User do
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to validate_presence_of(:full_name) }
  it { is_expected.to validate_uniqueness_of(:email) }
  it { is_expected.to have_many(:queue_items).order("position ASC") }
  it { is_expected.to have_many(:reviews).order("created_at DESC") }
  it { is_expected.to have_many(:following_relationships).class_name("Relationship") }
  it { is_expected.to have_many(:leading_relationships).class_name("Relationship") }
  
  describe "#queued_video?" do
    it "returns true if the user queued the video" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      Fabricate(:queue_item, user: user, video: video)
      expect(user.queued_video?(video)).to be true
    end
    it "returns false if the user hasn't queued the video" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      expect(user.queued_video?(video)).to be false
    end
  end
  
  describe "#follows?" do
    it "returns true if the user has a following relationship with another user" do
      alice = Fabricate(:user)
      bob = Fabricate(:user)
      Fabricate(:relationship, leader: bob, follower: alice)
      expect(alice.follows?(bob)).to be_true
    end
    it "returns false if the user does not have a following relationship with another user" do
      alice = Fabricate(:user)
      bob = Fabricate(:user)
      Fabricate(:relationship, leader: alice, follower: bob)
      expect(alice.follows?(bob)).to be_false
    end
  end
end