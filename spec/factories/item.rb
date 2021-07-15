FactoryBot.define do
  factory :item, class: Item do
    name { "Lorem Ipsum" }
    sell_in { 10 }
    quality { 99 }
    description { "dolor sit amet"}
  end
end
