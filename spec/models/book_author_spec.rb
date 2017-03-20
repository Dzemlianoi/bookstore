RSpec.describe BookAuthor, type: :model do
  context 'fields' do
    it { is_expected.to belong_to :book }
    it { is_expected.to belong_to :author }
  end
end