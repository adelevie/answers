require 'spec_helper'
include LoginHelpers

describe 'Contacts', :type => :feature do
  before { login_user }

  describe 'user views contact details page' do
    let(:contact) { create(:contact, name: 'Employment Benefits', number: '555-1234', url: 'www.example.com', address: '1234 Main St.', description: 'A place') }
    let(:category) { create(:category, name: 'Parking', description: 'Parking Description') }
    let(:author)  { create(:user) }

    it 'displays contact details and related articles' do
      article = create(:article, type: 'QuickAnswer', title: 'How Parking?', status: 'Published', contact: contact, user: author, category: category)
      visit admin_contact_path(contact)

      expect(page).to have_content(article.status)
      expect(page).to have_content(article.title)
      expect(page).to have_content(article.type)
      expect(page).to have_content(author.email)
      expect(page).to have_content(contact.name)
      expect(page).to have_content(contact.number)
      expect(page).to have_content(contact.url)
      expect(page).to have_content(contact.address)
      expect(page).to have_content(contact.description)
    end
  end

  describe 'user creates a new contact' do
    before { visit new_admin_contact_path }

    it 'successfully creates a contact' do
      fill_in 'Name', with: 'Dept of Parking'
      fill_in 'Phone Number', with: '555-1234'
      fill_in 'Address', with: '1234 Main St.'
      fill_in 'Description', with: 'Parking department'
      click_button 'Create Contact'

      expect(page).to have_content('Contact was successfully created.')
      expect(page).to have_content('Dept of Parking')
    end
  end

  describe 'user updates an existing contact' do
    let(:contact) { create(:contact, name: 'Employment Benefits', number: '555-1234', url: 'www.example.com', address: '1234 Main St.', description: 'A place') }
    before { visit edit_admin_contact_path(contact) }

    it 'successfully updates an existing contact' do
      fill_in 'Name', with: 'Human Resources'
      click_button 'Update Contact'

      expect(page).to have_content('Contact was successfully updated.')
      expect(page).to have_content('Human Resources')
    end
  end

  describe 'user deletes a category' do
    let(:contact) { create(:contact, name: 'Employment Benefits', number: '555-1234', url: 'www.example.com', address: '1234 Main St.', description: 'A place') }
    before { visit admin_contact_path(contact) }

    it 'successfully destroys a contact' do
      click_link 'Delete Contact'
      
      expect(page).to have_content('Contact was successfully destroyed.')
    end
  end
end
