class Picture < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :category
  has_many :comments, as: :commentable, dependent: :destroy
  validates :picture_name, presence: true

  # TODO Validate image field
end
