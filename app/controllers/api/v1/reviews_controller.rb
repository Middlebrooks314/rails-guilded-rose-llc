class Api::V1::ReviewsController < ApplicationController
  def index
    item = Item.find(params[:item_id])
    reviews = item.reviews.map { |review| review.text }
    json_response(reviews)
  end
end
