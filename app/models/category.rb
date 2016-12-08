class Category < ApplicationRecord
  has_many :pictures, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :users, through: :subscriptions

  validates :category_name, presence: true,
                            length: { maximum: 20 },
                            uniqueness: true
  validates_associated :pictures

  # TODO To lower all categories name
end
