# frozen_string_literal: true

RSpec.describe Address, type: :model do
  subject { Address.new(addressable: create(:user)) }
  context 'fields' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:address) }
    it { is_expected.to validate_presence_of(:city) }
    it { is_expected.to validate_presence_of(:phone) }
    it { is_expected.to validate_presence_of(:zip) }
    it { is_expected.to validate_presence_of(:kind) }
    it { is_expected.to allow_value('12345').for(:zip) }
    it { is_expected.not_to allow_value('12345678901').for(:zip) }
    it { is_expected.not_to allow_value('test').for(:zip) }
    it { is_expected.to allow_value('+380956565656').for(:phone) }
    it { is_expected.not_to allow_value('380956565656').for(:phone) }
    it { is_expected.not_to allow_value('0956565656').for(:phone) }
    it { is_expected.not_to allow_value('65656').for(:phone) }
    it { is_expected.not_to allow_value('sad').for(:phone) }
    it { is_expected.not_to allow_value('123123123123123123').for(:phone) }
  end
end
