# frozen_string_literal: true

feature 'Catalog', type: :feature, js: true do
  let!(:mobile) { create :category, name: 'Mobile Development' }
  let!(:design) { create :category, name: 'Design' }

  before do
    create_list(:book, 15, category: mobile)
    create_list(:book, 20, category: design)
  end

  background do
    visit category_books_path(mobile)
  end

  context 'catalog page' do
    scenario 'main elements' do
      expect(page).to have_content(I18n.t('books.catalog.catalog'))
      expect(page).to have_content(I18n.t('books.catalog.view_more'))
      expect(page).to have_selector('.filter-link', text: mobile.name)
    end

    scenario 'pagination' do
      expect(page).to have_selector('.general-thumb-wrap', count: 12)
      first('.btn-primary').click
      expect(page).to have_selector('.general-thumb-wrap', count: 15)
      expect(page).not_to have_content(I18n.t('books.catalog.view_more'))
    end
  end

  context 'books show or books ordering' do
    before(:each) do
      first('.thumbnail').hover
    end

    scenario 'book watching' do
      expect(page).to have_selector('.thumb-hover-link', visible: true)
      first('.thumb-hover-link').click
      expect(page).to have_content(I18n.t('books.show.back'))
    end

    scenario 'book watching' do
      expect(page).to have_selector('.thumb-hover-link > .fa-shopping-cart', visible: true)
      first('.thumb-hover-link > .fa-shopping-cart').click
      expect(page).to have_selector('.shop-icon', text: 1)
    end
  end

  context 'ordering' do
    scenario 'right ordering' do
      first('.dropdown-toggle > .dropdown-icon').click
      expect(page).to have_selector('.dropdown-toggle > .dropdown-icon', visible: true)
      expect(page).to have_content(I18n.t('books.sorting.new'))
    end
  end

  context 'right categories with quantity' do
    it 'should have categories name' do
      expect(page).to have_selector('.filter-link',  text: I18n.t('books.catalog.all'))
      expect(page).to have_selector('.filter-link',  text: mobile.name)
      expect(page).to have_selector('.filter-link',  text: design.name)
    end

    it 'should have right quantity nearly category' do
      expect(page).to have_selector('.general-badge',  text: 35)
      expect(page).to have_selector('.general-badge',  text: 15)
      expect(page).to have_selector('.general-badge',  text: 20)
    end
  end
end
