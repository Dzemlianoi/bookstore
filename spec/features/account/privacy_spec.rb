feature 'My account privacy', type: :feature, js: true do
  let(:user) { create :user }
  let!(:category) { create :category, name: 'Mobile Development' }

  before do
    sign_in(user)
    visit edit_user_registration_path(user)
  end

  before(:each) do
    first('[aria-controls=privacy]').click
    sleep(1)
  end

  context 'main elements' do
    scenario 'forms' do
      expect(page).to have_content(I18n.t('general.email'))
      expect(page).to have_content(I18n.t('general.password'))
      expect(page).to have_content(I18n.t('users.privacy.remove_link'))
    end

    scenario 'email' do
      expect(page).to have_field('user[email]', with: user.email)
    end
  end

  context 'remove account' do
    scenario 'button disabling' do
      expect(page).to have_selector('.remove-btn.disabled')
      first('.checkbox-icon').click
      expect(page).not_to have_selector('.remove-btn.disabled')
    end

    scenario 'removing account' do
      first('.checkbox-icon').click
      first('.remove-btn').click
      expect(page).to have_content(I18n.t('devise.registrations.destroyed'))
      expect(page).to have_content(I18n.t('layout.links.signup'))
    end
  end

  context 'change current password' do
    scenario 'change password' do
      fill_in I18n.t('users.privacy.old_password'), with: user.password
      fill_in I18n.t('users.privacy.new_password'), with: 'A123456'
      fill_in I18n.t('users.privacy.confirm_password'), with: 'A123456'
      expect(page).not_to have_css('div.alert-error')
    end
  end
end
