class Category < ApplicationRecord
  has_many :pictures, dependent: :destroy
  validates :category_name, presence: true,
                            length: { maximum: 20 },
                            uniqueness: true
  validates_associated :pictures

  # TODO To lower all categories name
end
