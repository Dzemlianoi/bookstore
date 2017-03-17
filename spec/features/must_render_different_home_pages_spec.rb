feature 'Show books', type: :feature do
  let(:mobile) { create :category, name: 'Mobile Development' }
  let(:design) { create :category, name: 'Web Design' }
  let(:book_mobile) { create :book, category: mobile }
  let(:book_design) { create :book, category: design }

  background do
    visit root_path
  end

  scenario 'Name of store' do
    expect(page).to have_content(I18n.t('general.project_name'))
  end
  scenario 'Get started button' do
    expect(page).to have_content(I18n.t('general.project_name'))
  end
end