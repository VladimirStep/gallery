class Picture < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :category, presence: true

  after_save :send_email_to_subscribers

  def send_email_to_subscribers
    if self.category
      subscribers = self.category.users
      picture = self
      subscribers.each do |subscriber|
        PicturesMailer.new_picture_email(subscriber, picture).deliver_later
      end
    end
  end
end
