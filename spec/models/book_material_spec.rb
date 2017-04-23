# frozen_string_literal: true

RSpec.describe BookMaterial, type: :model do
  context 'fields' do
    it { is_expected.to belong_to :book }
    it { is_expected.to belong_to :material }
  end
end
