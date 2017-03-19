feature 'My account addresses', type: :feature, js: true do
  let(:user) { create :user }
  let!(:category) { create :category, name: 'Mobile Development' }
  let(:book) { create :book, category: category }
  let!(:order) { create :order, :with_items, user: user }
  let(:attributes) { attributes_for(:users_address) }
  let(:wrong_attributes) { attributes_for(:users_address, :invalid) }

  before do
    sign_in(user)
  end

  background do
    visit order_step_path(id: :address)
  end

  context 'main elements' do
    scenario 'tabs' do
      expect(page).to have_content(I18n.t('users.addresses.billing_address'))
      expect(page).to have_content(I18n.t('users.addresses.shipping_address'))
      expect(page).to have_content(I18n.t('orders.use_billing'))
      expect(page).to have_selector('form')
    end
  end

  context 'all filling' do
    %w(shipping_address billing_address).each do |kind|
      scenario "User fill valid #{kind} data" do
        fill_address_checkout(kind, attributes)
        first('input[type=submit]').click
        expect(page).to have_field("#{kind}_first_name", with: attributes[:first_name])
      end
    end

    scenario 'User fill invalid data' do
      fill_address_checkout('shipping_address', wrong_attributes)
      fill_address_checkout('billing_address', wrong_attributes)
      first('input[type=submit]').click
      expect(page).to have_content('Phone is invalid')
    end

    scenario 'click use billing' do
      fill_address_checkout('billing_address', attributes)
      first('.checkbox-icon').click
      first('input[type=submit]').click
      expect(page).to have_selector('.shipping-fields', visible: false)
      first('input[type=submit]').click
    end

    scenario 'not to have confirm' do
      find('.step-number', text: '4').click
      expect(page).not_to have_selector('.step.active .step-number', text: '4')
    end
  end
end
