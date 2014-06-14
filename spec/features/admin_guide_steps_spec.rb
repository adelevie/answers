require 'spec_helper'
include LoginHelpers

# TODO the future of guides is uncertain. These tests may become irrelevant
describe 'Guide Steps', :type => :feature do
  before { login_user }

  describe 'user views a guide step details page' do
    let(:guide) { create(:guide) }
    let(:guide_step) { create(:guide_step, guide: guide) }

    before { visit admin_guide_step_path(guide_step) }

    it 'displays guide step details' do
      expect(page).to have_content(guide.title)
      expect(page).to have_content(guide_step.content)
      expect(page).to have_content(guide_step.preview)
      expect(page).to have_content(guide_step.step)
      expect(page).to have_content(guide_step.title)
    end
  end

  describe 'user creates a new guide step' do
    
    before do
      @guide = create(:guide)
      visit new_admin_guide_step_path
    end

    it 'successfully creates a new guide step when all fields are filled out' do
      select @guide.title, from: 'Guide'
      fill_in 'Title', with: 'Parking Step'
      fill_in 'Step', with: '1'
      fill_in 'Content', with: 'Parking Content'
      click_button 'Create Guide step'
      expect(page).to have_content('Guide step was successfully created.')
      expect(page).to have_content('Parking Step')
    end
  end

  describe 'user edits a guide step' do
    let(:guide_step) { create(:guide_step) }

    before { visit edit_admin_guide_step_path(guide_step) }

    it 'successfully changes a guide step' do
      fill_in 'Title', with: 'The best step'
      fill_in 'Content', with: 'More Parking'
      click_button 'Update Guide step'
      expect(page).to have_content('Guide step was successfully updated.')
      expect(page).to have_content('The best step')
      expect(page).to have_content('More Parking')
    end
  end

  describe 'user deletes a guide step' do
    let(:guide_step) { create(:guide_step) }

    before { visit admin_guide_step_path(guide_step) }

    it 'successfully deletes a guide step' do
      click_link 'Delete Guide Step'
      expect(page).to have_content('Guide step was successfully destroyed.')
    end
  end
end
