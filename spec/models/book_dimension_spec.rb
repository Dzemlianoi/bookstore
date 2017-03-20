RSpec.describe BookDimension, type: :model do
  context 'fields' do
    it { is_expected.to belong_to :book }
    it { is_expected.to validate_numericality_of(:height).is_greater_than_or_equal_to(0) }
    it { is_expected.to validate_numericality_of(:width).is_greater_than_or_equal_to(0) }
    it { is_expected.to validate_numericality_of(:depth).is_greater_than_or_equal_to(0) }
  end
end