require 'rails_helper'

RSpec.describe User, type: :model do
  subject { described_class.new(email: 'fOO@Bar.CoM', password: 'foobar') }

  it 'should downcase email before save' do
    expect(subject.send(:downcase_email)).to eq('foo@bar.com')
  end
end
