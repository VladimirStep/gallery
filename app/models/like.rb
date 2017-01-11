class Like < ApplicationRecord
  belongs_to :picture, counter_cache: true
  belongs_to :user

  validates :picture, presence: true
  validates :user, presence: true
end
