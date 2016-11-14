class Category < ApplicationRecord
  has_many :pictures, dependent: :destroy
  validates :category_name, presence: true, length: { maximum: 20 }
end
