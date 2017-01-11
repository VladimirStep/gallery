class Event < ApplicationRecord
  belongs_to :user

  validates :url, presence: true
  validates :user, presence: true
  validates :confirmation, inclusion: { in: [true, false] },
                           exclusion: { in: [nil] }
end
