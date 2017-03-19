RSpec.describe AddressesController, type: :controller do
  let(:user) { create :user }
  let(:address_params) { attributes_for(:users_address).merge(kind: 'billing') }

  before do
    allow(controller).to receive(:current_user).and_return(user)
  end

  context 'POST #create' do
    before do
      post :create, address: address_params
    end

    it 'renders :show template' do
      expect(response).to render_template(:edit)
    end

    it 'has a 200 status code' do
      expect(response.status).to eq(200)
    end

    it 'right assigns' do
      expect { post :create, address: address_params }.to change(Address, :count).by(1)
    end
  end

  context 'PUT #update' do
    before do
      patch :update,  kind: 'billing'
    end

    it 'renders :index template' do
      expect(response).to render_template(:edit)
    end

    it 'has a 200 status code' do
      expect(response.status).to eq(200)
    end
  end
end