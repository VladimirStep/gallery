class PicturesMailer < ApplicationMailer
  def new_picture_email(user, picture)
    @user = user
    @picture = picture
    mail(to: @user.email, subject: 'New picture for You')
  end
end
