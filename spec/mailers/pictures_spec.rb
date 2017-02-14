require 'rails_helper'

RSpec.describe PicturesMailer, type: :mailer do
  let(:user) { create(:user) }
  let(:picture) { create(:picture) }
  let(:mail) { PicturesMailer.new_picture_email(user, picture) }

  it 'renders the headers' do
    expect(mail.subject).to eq('New picture for You')
    expect(mail.to).to eq([user.email])
    expect(mail.from).to eq(['from@example.com'])
  end

  it 'renders the body' do
    expect(mail.body.encoded).to match('New Picture for You')
  end
end
