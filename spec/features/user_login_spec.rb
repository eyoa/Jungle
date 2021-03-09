require 'rails_helper'

RSpec.feature "UserLogins", type: :feature, js: true do
  before :each do
    user = User.create!(
      first_name: 'bugs',
      last_name: 'bunny',
      email: 'burrow@underground.com',
      password: '123456',
      password_confirmation: '123456'
    )  
    puts user.inspect
  end

  scenario "can login" do
    visit login_path
    fill_in 'email', with: 'burrow@underground.com'
    fill_in 'password', with: '123456'
    
    save_screenshot

    click_on 'Submit'

    expect(page).to have_content('Products')
    expect(page).to have_content('Welcome bugs!')
    save_screenshot
  end

end
