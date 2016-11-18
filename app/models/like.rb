class Like < ApplicationRecord
  belongs_to :picture, counter_cache: true
  belongs_to :user
end
