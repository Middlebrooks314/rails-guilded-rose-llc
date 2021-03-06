require_relative "item_presenter"

class Api::V1::ItemsController < ApplicationController
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  http_basic_authenticate_with name: ENV["USERNAME"], password: ENV["PASSWORD"], only: :create
  def index
    items = Item.all.map do |item|
      Api::V1::ItemPresenter.to_json(item)
    end
    json_response(items)
  end

  def show
    item = Item.find(params[:id])
    json_item = Api::V1::ItemPresenter.to_json(item)
    json_response(json_item)
  end

  def create
    item_presenter = Api::V1::ItemPresenter
    item = Item.create!(item_presenter.snakecase_keys(params))
    json_item = Api::V1::ItemPresenter.to_json(item)
    json_response(json_item, :created)
  end

  private

  def item_params
    params.permit(:name, :sell_in, :quality, :description)
  end
end
