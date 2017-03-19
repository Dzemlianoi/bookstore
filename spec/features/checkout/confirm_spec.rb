feature 'My account confirm', type: :feature, js: true do
  let(:user) { create :user }
  let(:category) { create :category, name: 'Mobile Development'}
  let(:book) { create :book, category: category}
  let!(:order) { create :order, :with_items, user: user }
  let!(:delivery) { create :delivery }
  let(:card_attributes) { attributes_for(:card) }
  let(:address_attributes) { attributes_for(:users_address) }

  before do
    sign_in(user)
  end

  background do
    visit order_step_path(id: :address)
  end

  context 'full fill' do
    before(:each) do
      full_fill_checkout(address_attributes, card_attributes)
    end

    scenario 'page' do
      expect(page).to have_content(I18n.t('users.addresses.billing_address'))
      expect(page).to have_content(I18n.t('users.addresses.shipping_address'))
      expect(page).to have_content(I18n.t('orders.shipments'))
      expect(page).to have_content(I18n.t('orders.payment_info'))
      expect(page).to have_selector('.table tr', count: 3)
    end

    scenario 'visit all another page' do
      visit order_step_path(id: :address)
      expect(page).to have_content(I18n.t('users.addresses.billing_address'))
      expect(page).to have_content(I18n.t('users.addresses.shipping_address'))
      visit order_step_path(id: :delivery)
      expect(page).to have_content(I18n.t('orders.delivery'))
      visit order_step_path(id: :payment)
      expect(page).to have_content(I18n.t('orders.card.credit'))
      expect(page).to have_content(I18n.t('orders.card.number'))
      expect(page).to have_content(I18n.t('orders.card.name'))
    end

    scenario 'go to final step' do
      first('a.btn.btn-default').click
      expect(page).to have_content(I18n.t('orders.thank_you'))
    end
  end
end
