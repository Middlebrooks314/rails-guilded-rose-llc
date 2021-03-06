desc "Seed client provided item data to database"
task add_item_seeds: :environment do
  Item.create!(
      [
        { name: "Aged Brie", sell_in: 7, quality: 5},
        { name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 21, quality: 3},
        { name: "Sulfuras, Hand of Ragnaros", sell_in: 14, quality: 100},
        { name: "Conjured Cauldron of Congee", sell_in: 10, quality: 10}
      ]
    )
  puts "Created #{Item.count} items!"
end
