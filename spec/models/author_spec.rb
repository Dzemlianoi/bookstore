# frozen_string_literal: true

RSpec.describe Author, type: :model do
  context 'fields' do
    it { is_expected.to have_many :book_authors }
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :surname }
    it { is_expected.to have_many(:books).through(:book_authors) }
  end
end
