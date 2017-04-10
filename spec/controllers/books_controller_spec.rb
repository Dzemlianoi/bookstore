# frozen_string_literal: true

RSpec.describe BooksController, type: :controller do
  let(:book) { create(:book) }

  before do
    allow(controller).to receive(:current_order).and_return(Order.new)
  end

  context 'GET #show' do
    before do
      get :show, params: { id: book.id }
    end

    it 'renders :show template' do
      expect(response).to render_template(:show)
    end

    it 'has a 200 status code' do
      expect(response.status).to eq(200)
    end

    it 'right assigns' do
      expect(assigns(:book)).to eq(book)
    end
  end

  context 'GET #index' do
    before do
      get :index
    end

    it 'renders :index template' do
      expect(response).to render_template(:index)
    end

    it 'has a 200 status code' do
      expect(response.status).to eq(200)
    end
  end
end
