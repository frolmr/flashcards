require "rails_helper"

RSpec.describe CardsMailer, type: :mailer do
  let(:mail) { CardsMailer.pending_cards_notification(user) }
  let(:user) { create :user }

  it 'should send email to correct email address' do
    expect(mail.to).to eq([user.email])
  end

  it 'should send email with correct subject' do
    expect(mail.subject).to eq('You have pending cards')
  end

  it 'should send from the corrrect address' do
    expect(mail.from).to eql(['from@example.com'])
  end

  it 'should send email with correct content' do
    expect(mail.html_part.body).to have_content("Здравствуйте")
    expect(mail.html_part.body).to have_content("Давненько вы не заходили к нам на")
    expect(mail.html_part.body).to have_content("У вас есть карточки у которых истек срок пересмотра")
  end
end
