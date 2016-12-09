class PicturesMailer < ApplicationMailer
  def new_picture_email(user, url)
    @user = user
    @url = url
    mail(to: @user.email, subject: 'New picture for You')
  end
end
