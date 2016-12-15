# Preview all emails at http://localhost:3000/rails/mailers/pictures
class PicturesPreview < ActionMailer::Preview
  def new_picture_email
    PicturesMailer.new_picture_email(User.first, Picture.first)
  end
end
