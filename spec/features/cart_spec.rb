# frozen_string_literal: true

feature 'Cart', type: :feature, js: true do
  let!(:mobile) { create :category, name: 'Mobile Development' }
  let(:mobile_book) { create(:book, category: mobile) }
  let(:user) { create :user }
  let(:coupon) { create :coupon }

  before do
    visit book_path(mobile_book)
    first('.btn-default.pull-right').click
    visit order_items_path
  end

  context 'main book page' do
    scenario 'main elements' do
      expect(page).to have_content(I18n.t('general.cart'))
      expect(page).to have_content(I18n.t('orders.product'))
      expect(page).to have_content(I18n.t('orders.price'))
      expect(page).to have_content(I18n.t('orders.quantity'))
      expect(page).to have_content(I18n.t('orders.subtotal'))
      expect(page).to have_selector('.general-cart-close')
    end
  end

  context 'item buttons' do
    scenario 'deleting' do
      first('.general-cart-close').click
      expect(page).not_to have_content(I18n.t('general.cart'))
    end

    scenario 'change quantity' do
      first('.fa-plus').click
      expect(page).to have_content("€#{2 * mobile_book.price}")
      expect(page).to have_field('.quantity-input', with: 2)
      first('.fa-minus').click
      expect(page).to have_field('.quantity-input', with: 1)
      expect(page).to have_content("€#{mobile_book.price}")
    end
  end

  context 'coupons' do
    scenario 'by default' do
      expect(page).to have_selector('#coupon_code')
    end

    scenario 'use invalid' do
      fill_in I18n.t('coupon.enter_coupon'), with: 'abc'
      first('.general-order-wrap input[type=submit]').click
      expect(page).to have_content(I18n.t('coupon.not_found'))
    end

    scenario 'use valid' do
      fill_in I18n.t('coupon.enter_coupon'), with: coupon.code
      first('.general-order-wrap input[type=submit]').click
      expect(page).to have_content(I18n.t('coupon.added'))
      expect(page).not_to have_field('#coupon_code')
    end
  end
end
