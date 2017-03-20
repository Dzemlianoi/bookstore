RSpec.describe OrderItem, type: :model do
  context 'fields' do
    it { is_expected.to belong_to :order }
    it { is_expected.to belong_to :book }
    it { is_expected.to validate_presence_of :book }
    it { is_expected.to validate_presence_of :quantity }
    it { is_expected.to validate_presence_of :order }
    it { is_expected.to validate_numericality_of(:quantity).is_greater_than 0 }
  end
end