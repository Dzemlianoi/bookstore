RSpec.describe Delivery, type: :model do
  context 'fields' do
    it { is_expected.to have_many :orders }
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_presence_of :price }
    it { is_expected.to validate_presence_of :pesimistic_days }
    it { is_expected.to validate_numericality_of(:pesimistic_days).is_greater_than 0 }
    it { is_expected.to validate_numericality_of(:optimistic_days).is_less_than 31 }
  end
end