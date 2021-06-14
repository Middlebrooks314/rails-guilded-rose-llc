class Spinach::Features::TestPostEndpoint < Spinach::FeatureSteps
  step "I create an Item" do
    HTTParty.post("http://localhost:3000/api/v1/items", {body: {name: "Foo", quality: 4, sellIn: 4}})
  end

  step "I create another Item" do
    HTTParty.post("http://localhost:3000/api/v1/items", {body: {name: "Bar", quality: 5, sellIn: 5}})
  end

  step "I create a third Item" do
    HTTParty.post("http://localhost:3000/api/v1/items", {body: {name: "FooBar", quality: 6, sellIn: 6}})
  end

  step "I request an index of Items" do
    @items = HTTParty.get("http://localhost:3000/api/v1/items")
  end

  step "I should see three items" do
    expect(@items.count).to eq(3)
  end

  step "each item should have fields name, quality, sell_in" do
    @items.sort! { |a, b| a["name"] <=> b["name"]}

    expect(@items[0]["name"]).to eq("Bar")
    expect(@items[0]["quality"].to_i).to eq(5)
    expect(@items[0]["sellIn"].to_i).to eq(5)

    expect(@items[1]["name"]).to eq("Foo")
    expect(@items[1]["quality"].to_i).to eq(4)
    expect(@items[1]["sellIn"].to_i).to eq(4)

    expect(@items[2]["name"]).to eq("FooBar")
    expect(@items[2]["quality"].to_i).to eq(6)
    expect(@items[2]["sellIn"].to_i).to eq(6)
  end

  step "the response should have a content type header type of `application/json`" do

    expect(@items.content_type).to eq("application/json")
  end
end
