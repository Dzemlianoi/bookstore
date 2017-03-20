RSpec.describe ReviewsController, type: :controller do
  let(:user) { create(:user) }
  let(:book) { create(:book) }
  let(:attributes_review) { attributes_for(:review) }

  context 'POST #create fail' do
    before do
      allow(controller).to receive(:current_user) { nil }
      post :create, params: { review: attributes_review, book_id: book.id }
    end

    it 'render show' do
      expect(response).to render_template('books/show')
    end

    it 'has a 200 status code' do
      expect(response.status).to eq(200)
    end
  end

  context 'POST #create success' do
    before do
      allow(controller).to receive(:current_user) { user }
      post :create, params: { review: attributes_review, book_id: book.id }
    end
    it 'right redirect' do
      expect(response).to redirect_to(book_path(book))
    end

    it 'flash success present' do
      expect(flash[:success]).to be_present
    end

    it 'should have right content' do
      expect(flash[:success]).to be_eql(I18n.t('flashes.success.review_success'))
    end
  end
end