require "rails_helper"
require_relative "../../lib/credentials_manager"

RSpec.describe "Items API", type: :request do
  describe "GET api/v1/items", type: :request do
    it "returns a successful response when there are no items" do

      get "/api/v1/items"

      expect(response).to have_http_status(:success)
      expect(json.size).to eq(0)
    end

    it "returns a single item" do

      FactoryBot.create(:item)

      get "/api/v1/items"

      expect(response).to have_http_status(:success)
      expect(json.size).to eq(1)
    end

    it "returns all the items" do
      FactoryBot.create(:item, name: "Raspberry", sell_in: 5, quality: 11)
      FactoryBot.create(:item, name: "Pineapple", sell_in: 6, quality: 12)
      FactoryBot.create(:item, name: "Basil", sell_in: 7, quality: 13)
      FactoryBot.create(:item, name: "Bananas", sell_in: 8, quality: 14)
      FactoryBot.create(:item, name: "Granola", sell_in: 9, quality: 15)

      get "/api/v1/items"

      expect(response).to have_http_status(:success)
      expect(json.size).to eq(5)
    end

    it "returns details for a single item" do
      FactoryBot.create(:item)

      get "/api/v1/items"

      parsed_body = JSON.parse(response.body).map(&:deep_symbolize_keys)
      expect(parsed_body.count).to eq(1)
      actual_item = parsed_body[0]
      expect(actual_item.fetch(:name)).to eq("Lorem Ipsum")
      expect(actual_item.fetch(:sellIn)).to eq(10)
      expect(actual_item.fetch(:quality)).to eq(99)
    end
  end

  describe "GET api/v1/items/:id" do
    context "when the record exists" do
      it "returns the item" do
        items = [
          FactoryBot.create(:item, name: "Raspberry", sell_in: 5, quality: 11),
        ]
        item_id = items.first.id

        get "/api/v1/items/#{item_id}"

        expect(json).not_to be_empty
        expect(json["id"]).to eq(item_id)
      end

      it "returns status code 200" do
        items = [
          FactoryBot.create(:item, name: "Raspberry", sell_in: 5, quality: 11),
        ]
        item_id = items.first.id

        get "/api/v1/items/#{item_id}"

        expect(response).to have_http_status(200)
      end
    end

    context "when the record does not exist" do
      it "returns status code 404" do
        item_id = 100

        get "/api/v1/items/#{item_id}"

        expect(response).to have_http_status(404)
      end

      it "returns a not found message" do
        item_id = 100

        get "/api/v1/items/#{item_id}"

        expect(response.body).to match(/Couldn't find Item/)
      end
    end
  end

  describe "POST api/v1/items" do
    before(:each) do
      @credentials_manager = CredentialsManager.new
      credentials = "Basic #{@credentials_manager.base64encode(Rails.application.credentials.username, Rails.application.credentials.password)}"
      @auth_headers = {authorization: credentials}
    end

    context "when item post request attributes are valid" do
      it "creates a new item in the database" do
        valid_attributes = {name: "Asparagus", sellIn: 10, quality: 25}

        expect { post "/api/v1/items", params: valid_attributes, headers: @auth_headers}.to change(Item, :count).by(+1)
      end

      it "returns status code 201" do
        valid_attributes = {name: "Asparagus", sellIn: 10, quality: 25}

        post "/api/v1/items", params: valid_attributes, headers: @auth_headers

        expect(response).to have_http_status(201)
      end
    end

    context "when item post request attributes are invalid" do
      it "does not create a new item in the database" do
        invalid_attributes = {title: "Lorem Ipsum"}

        expect { post "/api/v1/items", params: invalid_attributes, headers: @auth_headers }.to change(Item, :count).by(0)
      end

      it "returns status code 422 for invalid attributes" do
        invalid_attributes = {title: "Lorem Ipsum"}

        post "/api/v1/items", params: invalid_attributes, headers: @auth_headers

        expect(response).to have_http_status(422)
      end

      it "returns a failure message for missing attributes" do
        invalid_attributes = {title: "Lorem Ipsum"}

        post "/api/v1/items", params: invalid_attributes, headers: @auth_headers

        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end

      it "returns status code 401 for missing authorization headers" do
        valid_attributes = {name: "Lorem Ipsum", sellIn: 15, quality: 85}

        post "/api/v1/items", params: valid_attributes

        expect(response).to have_http_status(401)
      end

      it "returns a failure message for missing authorization headers" do
        valid_attributes = {name: "Lorem Ipsum", sellIn: 15, quality: 85}

        post "/api/v1/items", params: valid_attributes

        expect(response.body).to match(/HTTP Basic: Access denied./)
      end
    end
  end
end
