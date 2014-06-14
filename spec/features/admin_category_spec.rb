require 'spec_helper'
include LoginHelpers

describe 'Categories', :type => :feature do
  before { login_user }

  describe 'user views category details page' do
    let(:author) { create(:user) }
    let(:category) { create(:category, name: 'Parking', description: 'Parking Description') }
    let(:contact) { create(:contact) }

    it "displays the category's details and related articles" do
      article = create(:article, type: 'QuickAnswer', title: 'How Parking?', status: 'Published', contact: contact, user: author, category: category)
      visit admin_category_path(category)

      expect(page).to have_content(article.title)
      expect(page).to have_content(article.status)
      expect(page).to have_content(article.user.email)
      expect(page).to have_content(article.status)
      expect(page).to have_content(category.name)
      expect(page).to have_content(category.description)
      expect(page).to have_content(contact.name)
    end
  end

  describe 'user creates a category' do
    before { visit new_admin_category_path }

    it 'successfully creates a category' do
      fill_in 'Name', with: 'Parking'
      fill_in 'Description', with: 'Parking Description'
      click_button 'Create Category'
      
      expect(page).to have_content('Category was successfully created.')
      expect(page).to have_content('Parking')
    end
  end

  describe 'user edits a category' do
    let(:category) { create(:category, name: 'Parking',
                                        description: 'Parking Description') }

    before { visit edit_admin_category_path(category) }

    it 'successfully updates a category' do
      fill_in 'Name', with: 'Car Parking'
      click_button 'Update Category'
      
      expect(page).to have_content('Category was successfully updated.')
      expect(page).to have_content('Car Parking')
    end
  end

  describe 'user deletes a category' do
    let(:category) { create(:category, name: 'Parking',
                                        description: 'Parking Description') }

    before { visit admin_category_path(category) }
    it 'successfully destroys a category' do
      click_link 'Delete Category'
      
      expect(page).to have_content('Category was successfully destroyed.')
    end
  end
end
