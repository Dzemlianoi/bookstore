# frozen_string_literal: true

feature 'My account addresses', type: :feature, js: true do
  let(:user) { create :user }
  let!(:category) { create :category, name: 'Mobile Development' }
  let(:attributes) { attributes_for(:users_address) }
  let(:wrong_attributes) { attributes_for(:users_address, :invalid) }

  before do
    sign_in(user)
  end

  background do
    visit edit_user_registration_path(user)
  end

  context 'main elements' do
    scenario 'tabs' do
      expect(page).to have_selector('a.tab-link', text: I18n.t('users.addresses.link'))
      expect(page).to have_selector('a.tab-link', text: I18n.t('users.privacy.link'))
    end

    scenario 'main blocks' do
      expect(page).to have_selector('#address')
    end
  end

  context 'addresses filling' do
    %w(shipping billing).each do |kind|
      scenario "User fill valid #{kind} data" do
        fill_address(kind, attributes)
        expect(page).to have_selector(".#{kind}_form input[value=#{attributes[:first_name]}]")
      end
    end

    scenario 'User fill invalid data' do
      fill_address('shipping', wrong_attributes)
      expect(page).to have_content('Phoneis invalid')
    end
  end
end
