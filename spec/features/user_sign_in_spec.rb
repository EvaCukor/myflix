require 'spec_helper'

feature 'user signs in' do
  scenario 'with valid user, email and password' do
    alice = Fabricate(:user)
    sign_in(alice)
    expect(page).to have_content alice.full_name
  end
end