module LoginHelpers

	def login_user(user = create(:user, email: 'user@example.com', password: 'Mahalo43', password_confirmation: 'Mahalo43'))
		visit answers.new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'
	end

end