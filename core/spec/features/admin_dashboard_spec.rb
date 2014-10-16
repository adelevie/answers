require 'spec_helper'
include LoginHelpers

describe 'Admin Dashboard', :type => :feature do
  describe 'user views the admin dashboard page' do
    context 'with correct login credentials' do

      before do
        @article = create(:question, text: 'example title')
        @another_article = create(:question)
        # login_user
        # visit admin_dashboard_path
      end

      it 'displays a list of recent articles' do
        pending 'needs to be fixed for new engine layout'
        
        expect(page).to have_content('Recent Articles')
        expect(page).to have_content(@article.title)
        expect(page).to have_content(@another_article.title)
      end

      it 'displays details about the first article' do
        pending 'needs to be fixed for new engine layout'
        
        expect(page).to have_content(@article.type)
        expect(page).to have_content(@article.user.email)
      end

      it 'displays details about the second article' do
        pending 'needs to be fixed for new engine layout'
        
        expect(page).to have_content(@another_article.type)
        expect(page).to have_content(@another_article.user.email)
      end 

      it 'displays the article details page when the article title is clicked' do
        pending 'needs to be fixed for new engine layout'
        
        click_link @article.title
        expect(page).to have_content(@article.preview)
        expect(page).to have_content(@article.content)
      end
    end

    context 'without correct login credentials' do
      it 'redirects to the root path and provides a flash message' do
        visit admin_dashboard_path
      end
    end

  end
end
