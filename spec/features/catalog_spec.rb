feature 'Catalog', type: :feature, js: true do
  let!(:mobile) { create :category, name: 'Mobile Development' }

  background do
    visit category_path(mobile)
  end

  before do
    create_list(:book, 15, category: mobile)
  end

  context 'catalog page' do
    scenario 'main elements' do
      expect(page).to have_content(I18n.t('books.catalog.catalog'))
      expect(page).to have_content(I18n.t('books.catalog.view_more'))
      expect(page).to have_selector('.filter-link',  text: I18n.t('books.catalog.all'))
      expect(page).to have_selector('.filter-link',  text: mobile.name)
    end

    scenario 'pagination' do
      expect(page).to have_selector('general-thumb-wrap', count: 12)
      first('[rel = next]').click
      expect(page).to have_selector('general-thumb-wrap', count: 3)
      expect(page).not_to have_content(I18n.t('books.catalog.view_more'))
      expect(page).not_to have_content(I18n.t('books.catalog.prev'))
    end
  end
end