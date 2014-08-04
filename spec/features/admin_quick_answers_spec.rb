# encoding: utf-8
require 'spec_helper'
include LoginHelpers

describe 'Quick Answers', :type => :feature do
  before { login_user }

  describe 'user views the admin article details page' do
      let(:author)  { create(:user) }
      let(:contact) { create(:contact) }
      let(:quick_answer) { create(:article, type: "QuickAnswer", contact: contact ) }

    it 'shows quick answer details' do
      visit admin_quick_answer_path(quick_answer)

      expect(page).to have_content(contact.name)
      expect(page).to have_content(quick_answer.title)
    end

    it 'shows quick answer spanish content when it exists' do
      quick_answer.update_attributes(content_main_es: 'Vinícius Lages - Sem dúvida.')

      visit admin_quick_answer_path(quick_answer)
      expect(page).to have_content('Vinícius Lages - Sem dúvida.')
    end

    it 'shows quick answer chinese content when it exists' do
      quick_answer.update_attributes(content_main_cn: '國際特赦組織在六四事件')

      visit admin_quick_answer_path(quick_answer)
      expect(page).to have_content('國際特赦組織在六四事件')
    end
  end

  describe 'user creates a quick answer' do
    before do
      create(:category, name: 'Parking')
      create(:contact, name: 'migurski')
      create(:keyword, name: 'vehicles')
      visit new_admin_quick_answer_path
    end

    it 'successfully creates a new quick answer when all fields are filled out' do
      select 'Published', from: 'Status'
      select 'Parking', from: 'Category'
      select 'migurski', from: 'Contact'
      select 'vehicles', from: 'Keywords'
      fill_in 'Author', with: 'Mike Migurski'
      fill_in 'Title (English)', with: "Let's Park"
      fill_in 'Preview (English)', with: 'Parking Preview'
      fill_in 'Content (English)', with: 'Parking Summary'
      click_button 'Create Quick answer'

      expect(page).to have_content('Quick answer was successfully created.')
    end
  end

  describe 'user edits a quick answer' do
    let(:author)  { create(:user, email: 'pui@example.com') }
    let(:contact) { create(:contact) }
    let(:quick_answer) { create(:article, type: 'QuickAnswer', status: 'Draft', contact: contact, user: author) }

    before { visit edit_admin_quick_answer_path(quick_answer) }

    it 'successfully modifies a quick answer' do
      fill_in 'Title (English)', with: 'Why Parking?'
      select 'Published', from: 'Status'
      click_button 'Update Quick answer'
      expect(page).to have_content('Quick answer was successfully updated.')
      expect(page).to have_content('Why Parking?')
      expect(page).to have_content('Published')
    end
  end

  describe 'user deletes a quick answer' do
    let(:quick_answer) { create(:article, type: 'QuickAnswer') }
    before { visit admin_quick_answer_path(quick_answer) }

    it 'successfully deletes a quick answer' do
      skip 'TODO figure out why delete fails, "Jobs cannot be created for non-persisted records". Something to do with object persistence and delayed job'
      click_link 'Delete Quick Answer'
    end
  end
end
