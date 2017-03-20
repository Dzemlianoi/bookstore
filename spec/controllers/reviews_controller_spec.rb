RSpec.describe ReviewsController, type: :controller do
  let(:user) { create(:user) }
  let(:book) { create(:book) }
  let(:attributes_review) { attributes_for(:review, book: book) }

  context 'POST #create' do
    before do
      allow(controller).to receive(:current_user) { user }
      post :create, params: { review: attributes_review }
    end

    it 'render show' do
      expect(response).to render_template(:show)
    end

    it 'right redirect' do
      review = Review.new(attributes_review)
      expect(response).to redirect_to(book_path(review.book))
    end
  end
end