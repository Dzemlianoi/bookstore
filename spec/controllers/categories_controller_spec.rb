RSpec.describe CategoriesController, type: :controller do
  let!(:category) { create(:category) }
  let!(:book) { create(:book) }

  before do
    create_list(:book, 4, { category: category })
  end

  context 'GET #show' do
    before do
      get :show, params: { id: category.id }
    end

    it 'renders :show template' do
      expect(response).to render_template(:show)
    end

    it 'has a 200 status code' do
      expect(response.status).to eq(200)
    end

    it 'right assigns' do
      expect(assigns(:category)).to eq(category)
    end
  end

  context 'GET #default' do
    it 'redirects to first' do
      get :default
      expect(response).to redirect_to(category_path(category))
    end
  end
end