class Picture < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  after_create :send_email_to_subscribers

  def send_email_to_subscribers
    @url = url_for(self.image)
    # TODO It should return list of subscribers
    # @subscribers = self.category.users
  end
end
