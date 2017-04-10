# frozen_string_literal: true

RSpec.describe Material, type: :model do
  context 'fields' do
    it { is_expected.to have_many :book_materials }
    it { is_expected.to have_many(:books).through(:book_materials) }
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_uniqueness_of :name }
  end
end
