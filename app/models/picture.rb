class Picture < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
end
