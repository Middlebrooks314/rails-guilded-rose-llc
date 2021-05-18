class ItemPresenter
  def self.to_json(item)
    {
      id: item.id,
      name: item.name,
      quality: item.quality,
      sell_in: item.sell_in
    }
  end
end
class Api::V1::ItemsController < ApplicationController
  def index
    items = Item.all.map do |item|
      ItemPresenter.to_json(item)
    end
    render json: items
  end

  def show
    item = Item.find(params[:id])
    json_response(item)
  end

  def create
    item = Item.create!(item_params)
    json_response(item, :created)
  end

  private
  def item_params
    params.permit(:name, :sell_in, :quality)
  end
end
