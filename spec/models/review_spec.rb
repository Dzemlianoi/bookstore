RSpec.describe Review, type: :model do
  context 'fields' do
    it { is_expected.to belong_to :book }
    it { is_expected.to belong_to :user }
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :rating }
    it { is_expected.to validate_presence_of :comment_text }
    it { is_expected.to validate_presence_of :book }
    it { is_expected.to validate_presence_of :user }
    it { is_expected.to validate_inclusion_of(:rating).in_range(1..5) }
  end

  context 'aasm' do
    it 'should raise state on event' do
      expect(subject).to transition_from(:new).to(:approved).on_event(:approve)
      expect(subject).to transition_from(:new).to(:rejected).on_event(:reject)
    end
  end
end
