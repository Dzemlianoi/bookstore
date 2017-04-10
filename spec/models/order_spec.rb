RSpec.describe Order, type: :model do
  context 'fields' do
    it { is_expected.to have_many :addresses }
    it { is_expected.to have_many :order_items }
    it { is_expected.to have_many :books }
    it { is_expected.to have_one :coupon }
    it { is_expected.to belong_to(:card) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:delivery) }
    it { is_expected.to validate_uniqueness_of :track_number }
    it { is_expected.to validate_length_of(:track_number).is_at_most(25) }
  end

  context 'aasm' do
    it 'should raise state on event' do
      order = Order.new
      allow(order).to receive(:send_confirmation)
      allow(order).to receive(:send_treating)
      allow(order).to receive(:send_success)
      expect(order).to transition_from(:cart).to(:filled).on_event(:filled)
      expect(order).to transition_from(:filled).to(:in_confirmation).on_event(:in_confirmation)
      expect(order).to transition_from(:in_confirmation).to(:in_processing).on_event(:treat)
      expect(order).to transition_from(:in_processing).to(:in_delivery).on_event(:to_deliver)
      expect(order).to transition_from(:in_delivery).to(:completed).on_event(:complete)
    end
  end

  context 'addresses' do
    it '.has_valid addresses' do
      allow(subject).to receive(:shipping_address) { true }
      allow(subject).to receive(:billing_address) { true }
      expect(subject.valid_addresses?).to be_truthy
    end
  end

  context 'price' do
    it 'has right price discount for nil' do
      allow(subject).to receive(:coupon) { nil }
      expect(subject.discount).to eql(0)
    end

    it 'has right price delivery for nil' do
      allow(subject).to receive(:delivery) { nil }
      expect(subject.delivery_price).to eql(0)
    end
  end

  context 'proved' do
    it 'should return true if all present' do
      allow(subject).to receive(:card) { true }
      allow(subject).to receive(:delivery) { true }
      allow(subject).to receive(:valid_addresses?) { true }
      expect(subject.proved?).to be_truthy
    end
  end
end