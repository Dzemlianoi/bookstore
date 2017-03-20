RSpec.describe Category, type: :model do
  context 'fields' do
    it { is_expected.to have_many :books }
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_numericality_of(:count_books).is_greater_than_or_equal_to(0) }
  end

  context '.default' do
    it 'should return  first category' do
      category_first = create(:category)
      create(:category)
      expect(Category.default).to eql(category_first)
    end

    it 'should return mobile_cat' do
      create(:category)
      mobile_category = create(:category, name: 'Mobile Development')
      expect(Category.default).to eql(mobile_category)
    end
  end
end