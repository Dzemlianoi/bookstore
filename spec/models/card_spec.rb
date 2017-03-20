RSpec.describe Card, type: :model do
  context 'fields' do
    it { is_expected.to have_one :order }
    it { is_expected.to validate_presence_of(:cvv) }
    it { is_expected.to validate_presence_of(:expire_date) }
    it { is_expected.to validate_presence_of(:card_number) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:cvv).is_at_least 3 }
    it { is_expected.to validate_length_of(:name).is_at_most 50 }
    it { is_expected.to validate_length_of(:card_number).is_equal_to 16 }
    it { is_expected.to validate_numericality_of(:card_number) }
    it 'expire_date should be right' do
      expect { create(:card, expire_date: '11/22').not_to raise_error(Mongoid::Errors::Validations) }
    end
    it 'expire_date should not be right' do
      expect { create(:card, expire_date: '11/13').to raise_error(Mongoid::Errors::Validations) }
      expect { create(:card, expire_date: '19/19').to raise_error(Mongoid::Errors::Validations) }
    end
  end
end
