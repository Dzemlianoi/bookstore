feature 'My account card', type: :feature, js: true do
  let(:user) { create :user }
  let!(:category) { create :category, name: 'Mobile Development' }
  let(:book) { create :book, category: category }
  let!(:order) { create :order, :with_items, user: user }
  let(:card_attributes) { attributes_for(:card) }

  before do
    sign_in(user)
  end

  background do
    visit order_step_path(id: :payment)
  end

  context 'main elements' do
    scenario 'page' do
      expect(page).to have_content(I18n.t('orders.card.credit'))
      expect(page).to have_content(I18n.t('orders.card.number'))
      expect(page).to have_content(I18n.t('orders.card.name'))
      expect(page).to have_content(I18n.t('orders.card.mmyy'))
      expect(page).to have_content(I18n.t('orders.card.CVV'))
      expect(page).to have_selector('form')
    end
  end

  context 'card filling' do
    scenario 'User fill valid data' do
      fill_card_checkout(card_attributes)
      expect(page).to have_content(I18n.t('users.addresses.billing_address'))
    end


  end
end

