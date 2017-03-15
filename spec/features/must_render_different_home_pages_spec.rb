require 'rails_helper'
feature 'Show books', type: :feature do
  before do
    @mobile = create :category, name: 'Mobile Development'
    @design = create :category, name: 'Web design'
    @book_mobile = create :book, category: @mobile
    @book_design = create :book, category: @design
    visit root_path
    byebug
  end

  context 'First meet' do
    scenario 'Test' do
      expect(page).to have_content('Bookstore')
    end
  end
end