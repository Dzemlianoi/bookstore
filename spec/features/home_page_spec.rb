feature 'Show books', type: :feature, js: true, skip: true do
  let!(:mobile) { create :category, name: 'Mobile Development' }
  let!(:design) { create :category, name: 'Web Design' }
  let!(:book_mobile_first) { create :book, category: mobile }
  let!(:book_mobile_second) { create :book, category: mobile }
  let!(:book_design) { create :book, category: design }

  background do
    visit root_path
  end

  context 'main elements' do
    scenario 'main elements' do
      expect(page).to have_content(I18n.t('general.project_name'))
      expect(page).to have_content(I18n.t('general.welcome'))
      expect(page).to have_content(I18n.t('layout.links.home'))
      expect(page).to have_content(I18n.t('layout.links.shop'))
      expect(page).to have_css '.shop-icon'
    end
  end

  context 'different headers for' do
    scenario 'guests' do
      expect(page).to have_content(I18n.t('layout.links.signup'))
      expect(page).to have_content(I18n.t('layout.links.login'))
    end

    scenario 'users' do
      sign_in(create :user)
      expect(page).to have_content(I18n.t('layout.links.profile'))
    end
  end

  context 'books are displayed on page' do
    scenario 'slider show' do
      expect(page).to have_selector('h1', text: book_mobile_second.name)
      find('a.right.carousel-control').click
      expect(page).to have_selector('h1', text: book_mobile_first.name)
    end
    scenario 'bestsellers' do
      expect(page).to have_selector('.title', text: book_mobile_first.name)
      expect(page).to have_selector('.title', text: book_mobile_second.name)
      expect(page).to have_selector('p.pull-right', text: book_mobile_second.price)
    end
  end
end