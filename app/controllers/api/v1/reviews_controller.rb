class Api::V1::ReviewsController < ApplicationController
  def index
    item = Item.find(params[:item_id])
    reviews = item.reviews
    json_response(reviews)
  end
end
