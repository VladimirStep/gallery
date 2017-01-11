class ChatRoom < ApplicationRecord
  belongs_to :user
  has_many :messages, dependent: :destroy

  validates :title, presence: true,
                    length: { minimum: 2, maximum: 20 },
                    uniqueness: { case_sensitive: false }
  validates :user, presence: true
end
