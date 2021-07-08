require_relative "../../lib/credentials_manager"

class Spinach::Features::TestPostEndpoint < Spinach::FeatureSteps
  before do
    @credentials_manager = CredentialsManager.new
    @credentials = "Basic #{@credentials_manager.base64encode(ENV["USERNAME"], ENV["PASSWORD"])}"
    @auth_headers = {authorization: @credentials}
  end

  step "I create an Item" do

    options = {
      body: {name: "Foo", quality: 4, sellIn: 4, descripton: "Bar"},
      headers: @auth_headers
    }

    HTTParty.post("http://localhost:3000/api/v1/items", options)
  end

  step "I create another Item" do
    options = {
      body: {name: "Bar", quality: 5, sellIn: 5, description: "Foo"},
      headers: @auth_headers
    }

    HTTParty.post("http://localhost:3000/api/v1/items", options)
  end

  step "I create a third Item" do
    options = {
      body: {name: "FooBar", quality: 6, sellIn: 6},
      headers: @auth_headers
    }

    HTTParty.post("http://localhost:3000/api/v1/items", options)
  end

  step "I request an index of Items" do
    @items = HTTParty.get("http://localhost:3000/api/v1/items")
  end

  step "I should see three items" do
    expect(@items.count).to eq(3)
  end

  step "each item should have fields name, quality, sell_in, description" do
    @items.sort! { |a, b| a["name"] <=> b["name"]}

    expect(@items[0]["name"]).to eq("Bar")
    expect(@items[0]["quality"].to_i).to eq(5)
    expect(@items[0]["sellIn"].to_i).to eq(5)
    expect(@items[0]["description"]).to eq("Foo")

    expect(@items[1]["name"]).to eq("Foo")
    expect(@items[1]["quality"].to_i).to eq(4)
    expect(@items[1]["sellIn"].to_i).to eq(4)
    expect(@items[1]["description"]).to eq("Bar")

    expect(@items[2]["name"]).to eq("FooBar")
    expect(@items[2]["quality"].to_i).to eq(6)
    expect(@items[2]["sellIn"].to_i).to eq(6)
    expect(@items[2]["description"]).to eq("BarFoo")
  end

  step "the response should have a content type header type of `application/json`" do

    expect(@items.content_type).to eq("application/json")
  end
end
