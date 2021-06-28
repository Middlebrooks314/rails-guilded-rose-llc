require "rails_helper"

RSpec.describe Item, type: :model do
  subject do
    described_class.new(name: "Anything",
                        sell_in: 10,
                        quality: 50,
                        description: "Something Else"
                      )
  end

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a name" do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a sell in number" do
    subject.sell_in = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a quality number" do
    subject.quality = nil
    expect(subject).to_not be_valid
  end
end
