require 'spec_helper'
include LoginHelpers

describe 'Users', :type => :feature do
  before { login_user(create(:user, is_admin: true)) }

  describe 'admin user views user details page' do
    let(:user) { create(:user) }
    before { visit admin_user_path(user) }

    it 'displays user details' do
      expect(page).to have_content(user.email)
    end

  end

  describe 'admin user creates a new user' do
    before { visit new_admin_user_path }

    # TODO guh, creation doesn't have a success/failure message
    it 'successfully creates a user' do
      fill_in 'Email', with: 'another@example.com'
      fill_in 'user_password', with: 'Mahalo43'
      fill_in 'user_password_confirmation', with: 'Mahalo43'
      check 'Writer'
      click_button 'Create User'

      expect(page).to have_content('User Details')
    end
  end

  describe 'admin user updates an existing user' do
    before { visit edit_admin_user_path(create(:user)) }
  
    # TODO Blarh, same as creation
    it 'successfully updates an existing user' do
      fill_in 'Email', with: 'another@example.com'
      click_button 'Update User'

      expect(page).to have_content('User Details')
    end
  end

  describe 'admin user deletes a user' do
    before { visit admin_user_path(create(:user)) }
      
    it 'successfully destroys a user' do
      click_link 'Delete User'

      expect(page).to have_content('User was successfully destroyed.')
    end
  end
end
