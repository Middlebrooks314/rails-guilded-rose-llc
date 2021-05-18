require_relative 'item_presenter'

class Api::V1::ItemsController < ApplicationController
  def index
    items = Item.all.map do |item|
      Api::V1::ItemPresenter.to_json(item)
    end
    json_response(items)
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
