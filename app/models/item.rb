class Item < ActiveRecord::Base
  validates :name, presence: true
  validates :sell_in, presence: true
  validates :quality, presence: true
end
