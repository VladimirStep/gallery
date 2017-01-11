class Category < ApplicationRecord
  has_many :pictures, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :users, through: :subscriptions

  validates :category_name, presence: true,
                            length: { minimum: 2, maximum: 20 },
                            uniqueness: { case_sensitive: false }
  validates_associated :pictures

  before_save { self.category_name = category_name.downcase }
end
