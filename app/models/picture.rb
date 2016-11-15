class Picture < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :category
  validates :picture_name, presence: true

  # TODO Validate image field
end
