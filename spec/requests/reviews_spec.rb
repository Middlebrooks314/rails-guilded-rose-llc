require "rails_helper"

RSpec.describe "Reviews API", type: :request do
  describe "GET /api/v1/items/:item_id/reviews" do
    it "returns a nested json object containing reviews element" do
      FactoryBot.create(:item, id: 1)

      get "/api/v1/items/1/reviews"
      expect(response).to have_http_status(:success)
      expect(json.size).to eq(1)
      expect(json).to include("reviews")
    end

    it "returns an empty list of reviews when no items" do
      FactoryBot.create(:item, id: 1)

      get "/api/v1/items/1/reviews"
      expect(response).to have_http_status(:success)
      expect(json["reviews"].size).to eq(0)
    end

    it "returns a single review as a list" do
      FactoryBot.create(:item, id: 1)
      FactoryBot.create(:review, item: Item.find(1))

      get "/api/v1/items/1/reviews"
      expect(response).to have_http_status(:success)
      expect(json["reviews"].size).to eq(1)
    end

    it "returns the correct review text" do
      FactoryBot.create(:item, id: 1)
      FactoryBot.create(:review, text: "5 out of 5 stars", item: Item.find(1))

      get "/api/v1/items/1/reviews"

      expect(json["reviews"][0]["text"]).to eq("5 out of 5 stars")
    end

    it "returns many reviews as a list" do
      FactoryBot.create(:item, id: 1)
      FactoryBot.create(:review, item: Item.find(1))
      FactoryBot.create(:review, item: Item.find(1))

      get "/api/v1/items/1/reviews"
      expect(response).to have_http_status(:success)
      expect(json["reviews"].size).to eq(2)
    end
  end
end
