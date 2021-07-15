require "rails_helper"

describe Api::V1::ItemPresenter do
  describe ".to_json" do
    it "returns an item object with the id, name, sellIn, description, and quality attributes" do
      item = FactoryBot.create(
        :item,
          name: "Foo",
          sell_in: 5,
          quality: 11,
          description: "Bar"
        )
      presented_item = Api::V1::ItemPresenter.to_json(item)

      expect(presented_item).to include(:id)
      expect(presented_item).to include(:name)
      expect(presented_item).to include(:sellIn)
      expect(presented_item).to include(:quality)
      expect(presented_item).to include(:description)
      expect(presented_item).not_to include(:created_at)
      expect(presented_item).not_to include(:updated_at)
    end
  end

  it "returns item with camelCase attributes" do
    item = FactoryBot.create(
      :item,
        name: "Foo",
        sell_in: 5,
        quality: 11,
        description: "Bar")
    presented_item = Api::V1::ItemPresenter.to_json(item)

    expect(presented_item).to include(:sellIn)
    expect(presented_item).not_to include(:sell_in)
  end

  it "converts camelCase params to snake_case" do
    item_presenter = Api::V1::ItemPresenter
    params = {
      name: "Foo",
      sellIn: 5,
      quality: 11,
      description: "Bar"
    }

    actual = item_presenter.snakecase_keys(params)
    expected = {
      name: "Foo",
      sell_in: 5,
      quality: 11,
      description: "Bar"
    }

    expect(actual).to eq(expected)
  end

  it "it doesnt return extra params" do
    item_presenter = Api::V1::ItemPresenter
    params = {
      name: "Foo",
      sellIn: 5,
      quality: 11,
      description: "Bar",
      fooBar: 5
    }

    actual = item_presenter.snakecase_keys(params)
    expected = {
      name: "Foo",
      quality: 11,
      sell_in: 5,
      description: "Bar"
    }

    expect(actual).to eq(expected)
  end

  it "returns unsupplied required params set to nil" do
    item_presenter = Api::V1::ItemPresenter
    params = {
      name: "FooBar",
      sellIn: 5
    }

    actual = item_presenter.snakecase_keys(params)
    expected = {
      name: "FooBar",
      sell_in: 5,
      quality: nil,
      description: nil
    }

    expect(actual).to eq(expected)
  end

  it "returns empty string params as an empty string" do
    item_presenter = Api::V1::ItemPresenter
    params = {
      name: "",
      sellIn: 5,
      quality: 5,
      description: ""
    }

    actual = item_presenter.snakecase_keys(params)
    expected = {
      name: "",
      sell_in: 5,
      quality: 5,
      description: ""
    }

    expect(actual).to eq(expected)
  end

  it "returns nil attributes as nil" do
    item_presenter = Api::V1::ItemPresenter
    params = {
      name: "FooBar",
      sellIn: 5,
      quality: nil,
      description: "Bar"
    }

    actual = item_presenter.snakecase_keys(params)
    expected = {
      name: "FooBar",
      sell_in: 5,
      quality: nil,
      description: "Bar"
    }

    expect(actual).to eq(expected)
  end
end
