class Site < ApplicationRecord
  validates :name, presence: true,
                   length: { minimum: 2, maximum: 15 },
                   uniqueness: { case_sensitive: false }
  validates :address, presence: true,
                      length: { maximum: 253 },
                      url: true

  before_save { self.name = name.downcase }
end
