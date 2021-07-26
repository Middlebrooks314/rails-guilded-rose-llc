require "rails_helper"

describe Api::V1::ReviewPresenter do
  describe ".to_json" do
    it "returns a review with just text attribute" do
      item = FactoryBot.create(
        :item,
          name: "campbell's soup",
          sell_in: 2,
          quality: 10,
          description: "chicken broth with noodles"
      )
      review = FactoryBot.create(
        :review,
          text: "mmm mmm good",
          item: item
      )

      presented_review = Api::V1::ReviewPresenter.to_json(review)

      expect(presented_review).to include(:text)
      expect(presented_review).not_to include(:id)
      expect(presented_review).not_to include(:item)
      expect(presented_review).not_to include(:created_at)
      expect(presented_review).not_to include(:updated_at)
    end
  end
end
