# frozen_string_literal: true

RSpec.describe Coupon, type: :model do
  context 'fields' do
    it { is_expected.to belong_to :order }
    it { is_expected.to validate_presence_of(:code) }
    it { is_expected.to validate_presence_of(:discount) }
    it { is_expected.to validate_uniqueness_of(:code) }
    it { is_expected.to validate_length_of(:code).is_at_least 4 }
    it { is_expected.to validate_length_of(:code).is_at_most 40 }
    it { is_expected.to validate_numericality_of(:discount).is_greater_than 0 }
  end
end
