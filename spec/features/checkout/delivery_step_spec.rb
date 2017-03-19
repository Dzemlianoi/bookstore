feature 'My account delivery', type: :feature, js: true do
  let(:user) { create :user }
  let!(:category) { create :category, name: 'Mobile Development' }
  let(:book) { create :book, category: category }
  let!(:order) { create :order, :with_items, user: user }
  let!(:delivery) { create :delivery }

  before do
    create_list :delivery, 4
    sign_in(user)
  end

  background do
    visit order_step_path(id: :delivery)
  end

  context 'main' do
    scenario 'page elements' do
      expect(page).to have_content('Payment')
      expect(page).to have_selector('form')
    end

    scenario 'delivery elements' do
      expect(page).to have_content(delivery.title)
      expect(page).to have_content(delivery.price)
    end
  end

  context 'choose' do
    scenario 'next step by default' do
      first('span.radio-icon').click
      find('input[type=submit]').click
      expect(page).to have_content(I18n.t('users.addresses.billing_address'))
    end

    scenario 'not to have confirm' do
      find('.step-number', text: '4').click
      expect(page).not_to have_selector('.step.active .step-number', text: '4')
    end
  end
end
