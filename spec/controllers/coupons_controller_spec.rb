RSpec.describe CouponsController, type: :controller do
  let!(:category) { create(:category) }
  let(:book) { create(:book) }
  let(:coupon) { create(:coupon) }

  context 'right POST #create' do
    before do
      post :create, coupon: { code: coupon.id }
      allow(controller).to receive(:current_order) { Order.new }
      allow(:current_order).to receive(:subtotal_more_than_discount?).with(coupon).and_return(true)
    end

    it 'has a 200 status code' do
      expect(response.status).to eq(200)
    end

    it 'flash notice expected' do
      expect(flash[:notice]).to be_present
    end

    it 'has right status' do
      expect(response).to have_http_status(:updated)
    end

    it 'go to card' do
      expect(response).to redirect_to(order_items_path)
    end

    it 'right assigns' do
      expect(assigns(:coupon)).to eq(coupon)
    end
  end
end