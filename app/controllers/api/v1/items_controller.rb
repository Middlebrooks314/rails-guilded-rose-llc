class Api::V1::ItemsController < ApplicationController
  def index
    render json: Item.all
  end

  def show
    item = Item.find(params[:id])
    json_response(item)
  end
end
