class Api::V1::ReviewPresenter < ApplicationController
  attr_accessor :review

  def self.to_json(review)
    {
      text: review.text
    }
  end
end
