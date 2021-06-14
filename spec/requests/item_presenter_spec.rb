require "rails_helper"

describe Api::V1::ItemPresenter do
  describe ".to_json" do
    it "returns an item object with only the id, name, sellIn, and quality attributes" do
      item = FactoryBot.create(:item)

      presented_item = Api::V1::ItemPresenter.to_json(item)

      expect(presented_item).to include(:name)
      expect(presented_item).to include(:sellIn)
      expect(presented_item).to include(:quality)
      expect(presented_item).not_to include(:created_at)
      expect(presented_item).not_to include(:updated_at)
    end
  end

  it "returns item with camelCase attributes" do
    item = FactoryBot.create(:item, name: "FooBar", sell_in: 5, quality: 11)

    presented_item = Api::V1::ItemPresenter.to_json(item)

    expect(presented_item).to include(:sellIn)
    expect(presented_item).not_to include(:sell_in)
  end

  it "converts camelCase params to snake_case" do
    item_presenter = Api::V1::ItemPresenter
    params = {name: "FooBar", sellIn: 5, quality: 11}

    actual = item_presenter.snakecase_keys(params)
    expected = {"name" => "FooBar", "quality" => 11, "sell_in" => 5}

    expect(actual).to eq(expected)
  end

  it "it doesnt return extra params" do
    item_presenter = Api::V1::ItemPresenter
    params = {name: "FooBar", sellIn: 5, quality: 11, fooBar: 5}

    actual = item_presenter.snakecase_keys(params)
    expected = {"name" => "FooBar", "quality" => 11, "sell_in" => 5}

    expect(actual).to eq(expected)
  end

  it "returns unsupplied required params set to nil" do
    item_presenter = Api::V1::ItemPresenter
    params = {name: "FooBar", sellIn: 5}

    actual = item_presenter.snakecase_keys(params)
    expected = {"name" => "FooBar", "sell_in" => 5, "quality" => nil}

    expect(actual).to eq(expected)
  end

  it "returns empty string params as an empty string" do
    item_presenter = Api::V1::ItemPresenter
    params = {name: "", sellIn: 5, quality: 5}

    actual = item_presenter.snakecase_keys(params)
    expected = {"name" => "", "sell_in" => 5, "quality" => 5}

    expect(actual).to eq(expected)
  end

  it "returns nil attributes as nil" do
    item_presenter = Api::V1::ItemPresenter
    params = {name: "FooBar", sellIn: 5, quality: nil}

    actual = item_presenter.snakecase_keys(params)
    expected = {"name" => "FooBar", "sell_in" => 5, "quality" => nil}

    expect(actual).to eq(expected)
  end
end
