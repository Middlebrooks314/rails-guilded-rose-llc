require "rails_helper"

RSpec.describe Review, type: :model do
  before(:each) do
    @bacon = Item.new(
      name: "bacon",
      sell_in: 4,
      quality: 10,
      description: "meat"
    )
  end

  it "is valid with valid attributes" do
    subject = described_class.new(
      item: @bacon,
      text: "delicious meat"
    )
    expect(subject).to be_valid
  end

  it "is not valid without text" do
    subject = described_class.new(
      item: @bacon,
      text: nil
    )
    expect(subject).to_not be_valid
  end

  it "raises PG database error without text" do
    subject = described_class.new(
      item: @bacon,
      text: nil
    )

    expect {subject.save!(validate: false) }.to raise_error(ActiveRecord::NotNullViolation, /PG::NotNullViolation/)
  end
end
