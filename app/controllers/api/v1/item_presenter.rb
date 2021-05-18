class Api::V1::ItemPresenter < ApplicationController
  attr_accessor :item

  def self.to_json(item)
    {
      id: item.id,
      name: item.name,
      quality: item.quality,
      sellIn: item.sell_in
    }
  end
end
