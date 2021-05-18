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

  it "converts attributes from snake case to camel case" do
    item = FactoryBot.create(:item, name: "FooBar", sell_in: 5, quality: 11)

    presented_item = Api::V1::ItemPresenter.to_json(item)

    expect(presented_item).to include(:sellIn)
    expect(presented_item).not_to include(:sell_in)
  end
end
