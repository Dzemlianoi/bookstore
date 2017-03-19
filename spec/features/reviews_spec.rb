feature 'Reviews', type: :feature, js: true do
  let!(:book) { create :book }
  let!(:user) { create :user }
  let!(:review) { create :review, user: user, book: book, state: 'approved' }

  before do
    create_list(:review, 16, { user: (create :user), book: book, state: 'approved' })
  end

  background do
    visit book_path(book)
  end

  context 'watching' do
    scenario 'already existing reviews' do
      expect(page).to have_selector('.general-message-wrap', count: 17)
    end

    scenario 'rendering new review' do
      create :review, user: user, book: book, state: 'approved'
      page.driver.browser.navigate.refresh
      expect(page).to have_selector('.general-message-wrap', count: 18)
    end
  end

  context 'writing' do
    scenario 'guest cannot write reviews' do
      expect(page).not_to have_content(I18n.t('books.reviews.write'))
      expect(page).not_to have_selector('#review_name')
      expect(page).not_to have_selector('#review_comment_text')
    end

    scenario 'user can write review' do
      sign_in(user, book_path(book))
      expect(page).to have_content(I18n.t('books.reviews.write'))
      expect(page).to have_selector('#review_name')
      expect(page).to have_selector('#review_comment_text')
      fill_review(review)
      expect(page).to have_content(I18n.t('flashes.success.review_success'))
      expect(page).to have_content(review.name)
      expect(page).to have_content(review.comment_text)
    end
  end
end
