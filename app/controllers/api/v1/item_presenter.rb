class Api::V1::ItemPresenter < ApplicationController
  attr_accessor :item

  def self.to_json(item)
    {
      id: item.id,
      name: item.name,
      quality: item.quality,
      sellIn: item.sell_in,
      description: item.description
    }
  end

  def self.snakecase_keys(params)
    {
      name: params[:name],
      sell_in: params[:sellIn],
      quality: params[:quality],
      description: params[:description]
    }
  end
end
