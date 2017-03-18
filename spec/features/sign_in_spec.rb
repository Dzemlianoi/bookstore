feature 'Sign in', type: :feature, js: true, skip: true do
  let(:user) { create :user }
  let!(:category) { create :category, name: 'Mobile Development' }

  context 'valid user data' do
    scenario 'Log in' do
      sign_in(user)
      expect(page).to have_content(I18n.t('devise.sessions.signed_in'))
    end

    scenario 'Log out' do
      sign_in(user)
      click_on(I18n.t('layout.links.profile'))
      click_on(I18n.t('layout.links.logout'))
      expect(page).to have_content(I18n.t('devise.sessions.signed_out'))
    end
  end

  context 'invalid user data' do
    scenario 'show errors' do
      user.password = 'test12'
      sign_in(user)
      expect(page).to have_content(I18n.t('devise.failure.not_found_in_database', authentication_keys: :Email))
    end
  end

  context 'facebook' do
    scenario 'log in' do
      mock_auth
      visit new_user_session_path
      first('.fa-facebook-official').click
      expect(page).to have_content(I18n.t('devise.omniauth_callbacks.success',
                                          kind: :Facebook))
    end
  end
end
