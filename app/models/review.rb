class Review < ApplicationRecord
  belongs_to :item
  validates :text, presence: true
end
