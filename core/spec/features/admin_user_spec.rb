require 'spec_helper'
include LoginHelpers

describe 'Users', :type => :feature do
#  before { login_user(create(:user, is_admin: true)) }

  describe 'admin user views user details page' do
    let(:user) { create(:user) }
    before { visit admin_answers_user_path(user) }

    it 'displays user details' do
      pending 'needs to be fixed for new engine layout'

      expect(page).to have_content(user.email)
    end

  end

  describe 'admin user creates a new user' do
    before { visit new_admin_answers_user_path }

    it 'successfully creates a user' do
      pending 'needs to be fixed for new engine layout'

      fill_in 'Email', with: 'another@example.com'
      fill_in 'user_password', with: 'Mahalo43'
      fill_in 'user_password_confirmation', with: 'Mahalo43'
      check 'Writer'
      click_button 'Create User'

      expect(page).to have_content('User Details')
      expect(page).to have_content('User was successfully created.')
    end
  end

  describe 'admin user updates an existing user' do
    before { visit edit_admin_answers_user_path(create(:user)) }

    it 'successfully updates an existing user' do
      pending 'needs to be fixed for new engine layout'

      fill_in 'Email', with: 'another@example.com'
      click_button 'Update User'

      expect(page).to have_content('User Details')
      expect(page).to have_content('User was successfully updated')
    end
  end

  describe 'admin user deletes a user' do
    before { visit admin_answers_user_path(create(:user)) }

    it 'successfully destroys a user' do
      pending 'needs to be fixed for new engine layout'

      click_link 'Delete User'

      expect(page).to have_content('User was successfully destroyed.')
    end
  end
end
