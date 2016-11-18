require 'rails_helper'

RSpec.describe CardAttrUpdater do
  let!(:card) { create(:card) }

  context 'results on 10 seconds correct answer:' do
    subject { described_class.new(card, 10) }

    it 'should get quality factor 5' do
      expect(subject.send(:get_quality_factor)).to eq(5)
    end

    it 'should get e-factor 0.1 when quality factor is 5' do
      expect(subject.send(:get_e_factor, 5)).to eq(0.1)
    end

    it 'should set card e-factor to 2.6' do
      expect { subject.send(:set_e_factor, 0.1) }.to change { card.e_factor }.from(2.5).to(2.6)
    end

    it 'should set review interval to 6 for first repetition (initial)' do
      expect { subject.send(:set_review_interval) }.to change { card.review_interval }.from(1).to(6)
    end

    it 'should set review_date after 6 days' do
      card.review_interval = 6
      subject.send(:set_review_date_and_update)
      expect(card.review_date.to_i).to eq((Time.now + 6.days).to_i)
    end
  end

  context 'results on 30 seconds correct answer:' do
    subject { described_class.new(card, 30) }

    before(:each) do
      card.repetition = 2
      card.review_interval = 6
    end

    it 'should get quality factor 4' do
      expect(subject.send(:get_quality_factor)).to eq(4)
    end

    it 'should get e-factor 0 when quality factor is 4' do
      expect(subject.send(:get_e_factor, 4)).to eq(0)
    end

    it 'should not change card e-factor when q-factor is 4' do
      expect { subject.send(:set_e_factor, 0) }.not_to change { card.e_factor }
    end

    it 'should change review interval to 15 for new repetition' do
      expect { subject.send(:set_review_interval) }.to change { card.review_interval }.from(6).to(15)
    end

    it 'should set review_date after 15 days' do
      card.review_interval = 15
      subject.send(:set_review_date_and_update)
      expect(card.review_date.to_i).to eq((Time.now + 15.days).to_i)
    end
  end

  context 'results on 50 seconds correct answer:' do
    subject { described_class.new(card, 50) }

    before(:each) do
      card.repetition = 3
      card.review_interval = 15
    end

    it 'should get quality factor 3' do
      expect(subject.send(:get_quality_factor)).to eq(3)
    end

    it 'should get e-factor -0.14 when quality factor is 3' do
      expect(subject.send(:get_e_factor, 3).round(2)).to eq(-0.14)
    end

    it 'should set card e-factor to 2.4' do
      expect { subject.send(:set_e_factor, -0.14) }.to change { card.e_factor }.from(2.5).to(2.36)
    end

    it 'should change review interval to 38 for new repetition' do
      expect { subject.send(:set_review_interval) }.to change { card.review_interval }.from(15).to(38)
    end

    it 'should set review_date after 38 days' do
      card.review_interval = 38
      subject.send(:set_review_date_and_update)
      expect(card.review_date.to_i).to eq((Time.now + 38.days).to_i)
    end
  end

  context 'results on more than 60 seconds correct answer:' do
    subject { described_class.new(card, 70) }
    before(:each) do
      card.repetition = 2
      card.review_interval = 15
    end

    it 'should get quality factor 2' do
      expect(subject.send(:get_quality_factor)).to eq(2)
    end

    it 'should reset card repetition' do
      expect { subject.send(:reset_card_attributes) }.to change { card.repetition }.to(1)
    end

    it 'should reset card review interval' do
      expect { subject.send(:reset_card_attributes) }.to change { card.review_interval }.to(1)
    end
  end
end
