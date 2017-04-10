RSpec.describe OrderItemsController, type: :controller do
  let!(:category) { create(:category) }
  let(:book) { create(:book, category: category) }
  let(:user) { create :user }
  let(:order_item) { create(:order_item, book: book) }
  let(:my_order) { create(:order, :with_items) }

  context 'GET #index' do

    it 'redirect unless current_order_active?' do
      allow(controller).to receive(:current_order_active?) { false }
      get :index
      expect(response).to redirect_to(root_path)
    end

    it 'right render' do
      allow(controller).to receive(:current_order_active?) { true }
      allow(controller).to receive_message_chain(:last_active_order, :order_items, :decorate)
      get :index
      expect(response).to render_template(:index)
    end
  end

  context 'POST :create' do
    before do
      request.env['HTTP_REFERER'] = 'where_i_came_from'
    end

    it 'should change quantity of guests' do
      expect{controller.send(:guest_create)}.to change{ User.count }.by(1)
    end

    it 'should create guest' do
      allow(controller).to receive(:current_user_or_guest) { false }
      allow_any_instance_of(Order).to receive(:book_in_order?) { true }
      post :create, params: { order_item: { quantity: order_item.quantity, book_id: order_item.book_id  } }
      expect(controller).to receive(:guest_create)
      expect(flash[:danger]).to be_present
      expect(response).to redirect_to('where_i_came_from')
    end
  end

  context 'DELETE #destroy' do
    it 'should delete order item' do
      allow(controller).to receive(:current_order) { my_order }
      item_id = my_order.order_items.first.id
      expect{ delete :destroy, params:{ id: item_id } }.to change{ OrderItem.count }.by(1)
    end
  end
end