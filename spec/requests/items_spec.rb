require 'rails_helper'

describe 'Items API', type: :request do
  it 'returns a successful response when there are no items' do

    get '/api/v1/items'

    expect(response).to have_http_status(:success)
    expect(JSON.parse(response.body).size).to eq(0)
  end
  it 'returns a single item' do
    FactoryBot.create(:item, name: 'Raspberry', sell_in: 5, quality: 10)

    get '/api/v1/items'

    expect(response).to have_http_status(:success)
    expect(JSON.parse(response.body).size).to eq(1)
  end

  it 'returns all the items' do
    FactoryBot.create(:item, name: 'Raspberry', sell_in: 5, quality: 11)
    FactoryBot.create(:item, name: 'Pineapple', sell_in: 6, quality: 12)
    FactoryBot.create(:item, name: 'Basil', sell_in: 7, quality: 13)
    FactoryBot.create(:item, name: 'Bananas', sell_in: 8, quality: 14)
    FactoryBot.create(:item, name: 'Granola', sell_in: 9, quality: 15)

    get '/api/v1/items'

    expect(response).to have_http_status(:success)
    expect(JSON.parse(response.body).size).to eq(5)
  end
end
