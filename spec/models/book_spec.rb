RSpec.describe Book, type: :model do
  context 'fields' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :price }
    it { is_expected.to validate_presence_of :publication_year }
    it { is_expected.to validate_length_of(:description).is_at_most 1000 }
    it { is_expected.to belong_to :category }
    it { is_expected.to have_one :book_dimension }
    it { is_expected.to have_many :book_materials }
    it { is_expected.to have_many :book_authors }
    it { is_expected.to have_many :reviews }
    it { is_expected.to have_many :order_items }
    it { is_expected.to have_many(:materials).through(:book_materials) }
    it { is_expected.to have_many(:authors).through(:book_authors) }
    it { is_expected.to have_many(:orders).through(:order_items) }
  end

  describe 'book counting' do
    let(:category) { create(:category)}
    let!(:book) { create(:book, category: category) }
    let!(:book1) { create(:book, category: category) }

    it 'increment counting' do
      expect(category.count_books).to eql(2)
    end

    it 'decrement counting' do
      book1.destroy
      expect(category.count_books).to eql(1)
    end
  end
end