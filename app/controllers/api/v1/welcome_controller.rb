class Api::V1::WelcomeController < ApplicationController
  def index
    output = 'Welcome to the Gilded Rose LLC store!!!!!!'
    render json: output
  end
end
