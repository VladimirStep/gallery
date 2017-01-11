class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :picture

  validates :body, presence: true,
                   length: { minimum: 2, maximum: 2000 }
  validates :user, presence: true
  validates :picture, presence: true
end
