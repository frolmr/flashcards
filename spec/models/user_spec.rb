require 'rails_helper'

RSpec.describe User, type: :model do
  subject { described_class.new(email: 'fOO@Bar.CoM', password: 'foobar') }

  it 'should downcase email before save' do
    expect(subject.send(:downcase_email)).to eq('foo@bar.com')
  end

  it 'should send email about pending cards' do
    @user = create(:user)
    @deck = create(:deck, user: @user)
    @card = create(:card, deck: @deck, user: @user)
    expect { User.notify_pending_cards }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end
end
