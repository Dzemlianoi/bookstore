# frozen_string_literal: true

feature 'Sign up', type: :feature, js: true do
  let!(:category) { create :category, name: 'Mobile Development' }

  context 'successfull' do
    scenario 'sign up' do
      visit new_user_registration_path
      fill_in 'email', with: FFaker::Internet.email
      fill_in 'user_password', with: '123456'
      fill_in 'user_password_confirmation', with: '123456'
      first('.registrate').click
      expect(page).to have_content(I18n.t('devise.registrations.signed_up_but_unconfirmed'))
    end
  end
end
