require 'rails_helper'

RSpec.describe 'Items API', type: :request do
  describe 'GET /items', type: :request do
    it 'returns a successful response when there are no items' do

      get '/api/v1/items'

      expect(response).to have_http_status(:success)
      expect(json.size).to eq(0)
    end

    it 'returns a single item' do

      FactoryBot.create(:item)

      get '/api/v1/items'

      expect(response).to have_http_status(:success)
      expect(json.size).to eq(1)
    end

    it 'returns all the items' do
      FactoryBot.create(:item, name: 'Raspberry', sell_in: 5, quality: 11)
      FactoryBot.create(:item, name: 'Pineapple', sell_in: 6, quality: 12)
      FactoryBot.create(:item, name: 'Basil', sell_in: 7, quality: 13)
      FactoryBot.create(:item, name: 'Bananas', sell_in: 8, quality: 14)
      FactoryBot.create(:item, name: 'Granola', sell_in: 9, quality: 15)

      get '/api/v1/items'

      expect(response).to have_http_status(:success)
      expect(json.size).to eq(5)
    end

    it 'returns details for a single item' do
      item = FactoryBot.create(:item)

      get '/api/v1/items'

      expect(item['name']).to eq('Lorem Ipsum')
      expect(item['sell_in']).to eq(10)
      expect(item['quality']).to eq(99)
    end
  end

  describe 'GET /items/:id' do
    context 'when the record exists' do
      it 'returns the item' do
        items = FactoryBot.create_list(:item, 10)
        item_id = items.first.id

        get "/api/v1/items/#{item_id}"

        expect(json).not_to be_empty
        expect(json['id']).to eq(item_id)
      end

      it 'returns status code 200' do
        items = FactoryBot.create_list(:item, 10)
        item_id = items.first.id

        get "/api/v1/items/#{item_id}"

        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      it 'returns status code 404' do
        item_id = 100

        get "/api/v1/items/#{item_id}"

        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        item_id = 100

        get "/api/v1/items/#{item_id}"

        expect(response.body).to match(/Couldn't find Item/)
      end
    end
  end
end
