FactoryBot.define do
  factory :review, class: Review do
    text { "a good item" }
    item { association :item }
  end
end
