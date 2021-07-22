class Item < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :sell_in, presence: true
  validates :quality, presence: true
  has_many :reviews
end
