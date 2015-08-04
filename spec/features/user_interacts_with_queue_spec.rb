require 'spec_helper'

feature 'user interacts with the queue' do 

  scenario 'user adds and reorder videos in the queue' do
    comedy = Fabricate(:category)
    monk = Fabricate(:video, title: 'Monk', category: comedy)
    futurama = Fabricate(:video, title: 'Futurama', category: comedy)
    south_park = Fabricate(:video, title: 'South Park', category: comedy)

    sign_in
    
    add_video_to_queue(monk)
    
    visit video_path(monk)
    page.should_not have_content('+ My Queue')
    
    add_video_to_queue(south_park)
    add_video_to_queue(futurama)
    
    set_video_position(monk, 3)
    set_video_position(south_park, 1)
    set_video_position(futurama, 2)
    
    # find("input[data-video-id='#{monk.id}']").set(3)
    # find("input[data-video-id='#{south_park.id}']").set(1)
    # find("input[data-video-id='#{futurama.id}']").set(2)
    
    click_button "Update Instant Queue"
    
    # expect(find("input[data-video-id='#{south_park.id}']").value).to eq("1")
    # expect(find("input[data-video-id='#{futurama.id}']").value).to eq("2")
    # expect(find("input[data-video-id='#{monk.id}']").value).to eq("3")
    
    expect_video_position(south_park, 1)
    expect_video_position(futurama, 2)
    expect_video_position(monk, 3)
  end
end

def add_video_to_queue(video)
  visit home_path
  find("a[href='/videos/#{video.id}']").click
  expect(page).to have_content(video.title)
  click_link '+ My Queue'
end

def set_video_position(video, position)
  within(:xpath, "//tr[contains(.,'#{video.title}')]") do
    fill_in 'queue_items[][position]', with: position
  end
end

def expect_video_position(video, position)
   expect(find(:xpath, "//tr[contains(.,'#{video.title}')]//input[@type='text']").value).to eq(position.to_s)
end