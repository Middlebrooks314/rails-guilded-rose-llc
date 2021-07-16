require "rails_helper"

RSpec.describe Review, type: :model do
  subject do
    bacon = Item.new(
      name: "bacon",
      sell_in: 4,
      quality: 10,
      description: "meat"
    )

    described_class.new(
      item: bacon,
      text: "delicious meat"
    )
  end

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without text" do
    subject.text = nil
    expect(subject).to_not be_valid
  end
end
