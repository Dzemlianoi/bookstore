# frozen_string_literal: true

RSpec.describe User, type: :model do
  context 'fields' do
    it { is_expected.to have_many(:reviews).dependent(:destroy) }
    it { is_expected.to have_many :orders }
    it { is_expected.to have_many(:addresses).dependent(:destroy) }
    it { is_expected.to have_one(:image).dependent(:destroy) }
  end

  context 'roles' do
    it 'admin' do
      user = create(:user, :admin)
      expect(user.admin?).to be_truthy
    end

    it 'not admin' do
      expect(subject.admin?).to be_falsey
    end

    it 'guest' do
      allow(subject).to receive(:guest_token) { true }
      expect(subject.guest?).to be_truthy
    end

    it 'not guest' do
      expect(subject.guest?).to be_falsey
    end

    it 'create by token increases User' do
      expect { User.create_by_token }.to change { User.count }.by(1)
    end

    it 'set fake password changes password' do
      expect { subject.set_fake_password }.to change { subject.password }
    end
  end
end
