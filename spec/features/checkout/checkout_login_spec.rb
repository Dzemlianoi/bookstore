feature 'Checkout login', type: :feature, js: true do
  let!(:mobile) { create :category, name: 'Mobile Development' }
  let!(:mobile_book) { create(:book, :long_description)  }
  let!(:user) { create :user }

  background do
    visit book_path(mobile_book)
    first('.btn-default.pull-right').click
    visit order_step_path(id: :address)
  end

  context 'main' do
    scenario 'elements' do
      expect(page).to have_content(I18n.t('users.returning_customer'))
      expect(page).to have_content(I18n.t('users.new_customer'))
      expect(page).to have_selector('form', count: 2)
    end
  end

  context 'sign in' do
    scenario 'correct' do
      find('.log-in #email').set user.email
      find('.log-in #user_password').set user.password
      first('.log-in input[type=submit]').click
      expect(page).to have_content(I18n.t('users.addresses.billing_address'))
    end

    scenario 'incorrect' do
      find('.log-in #email').set user.email
      find('.log-in #user_password').set 'lol'
      first('.log-in input[type=submit]').click
      expect(page).to have_selector('div.alert-danger')
    end

    scenario 'via facebook' do
      mock_auth
      first('.fa-facebook-official').click
      expect(page).to have_content(I18n.t('devise.omniauth_callbacks.success',
                                          kind: :Facebook))
      expect(page).to have_content(I18n.t('users.addresses.billing_address'))
    end
  end

  context 'sign up' do
    scenario 'correct' do
      find('.sign-up #email').set FFaker::Internet.email
      first('.sign-up input[type=submit]').click
      expect(page).to have_content(I18n.t('users.addresses.billing_address'))
      expect(page).to have_content(I18n.t('devise.registrations.signed_up'))
    end
  end
end
