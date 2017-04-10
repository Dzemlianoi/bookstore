# frozen_string_literal: true

feature 'Book', type: :feature, js: true do
  let!(:mobile) { create :category, name: 'Mobile Development' }
  let!(:mobile_book) { create(:book, :long_description) }
  let!(:user) { create :user }
  let!(:review) { create :review, user: user, book: mobile_book }

  background do
    visit book_path(mobile_book)
  end

  context 'main book page' do
    scenario 'main elements' do
      expect(page).to have_content(I18n.t('books.show.back'))
      expect(first('input.btn-default').value).to eq I18n.t('books.show.cart_add')
    end

    scenario 'book params' do
      expect(page).to have_content(mobile_book.name)
      expect(page).to have_content(mobile_book.publication_year)
      expect(page).to have_content(mobile_book.price)
    end

    scenario 'book description' do
      expect(page).to have_content(mobile_book.description[0...247] << '...')
      find('.read-more').click
      expect(page).to have_content(mobile_book.description)
    end
  end
end
