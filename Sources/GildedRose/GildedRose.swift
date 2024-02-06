public class GildedRose {
    var items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    public func updateQuality() {
        for i in 0 ..< items.count {
            if items[i].name != "Aged Brie", items[i].name != "Backstage passes to a TAFKAL80ETC concert" {
                if items[i].quality > 0 {
                    if items[i].name != "Sulfuras, Hand of Ragnaros" {
                        items[i].updateQuality(difference: -1)
                    }
                }
            } else {
                if items[i].quality < 50 {
                    items[i].updateQuality(difference: 1)

                    if items[i].name == "Backstage passes to a TAFKAL80ETC concert" {
                        if items[i].sellIn < 11 {
                            if items[i].quality < 50 {
                                items[i].updateQuality(difference: 1)
                            }
                        }

                        if items[i].sellIn < 6 {
                            if items[i].quality < 50 {
                                items[i].updateQuality(difference: 1)
                            }
                        }
                    }
                }
            }

            if items[i].name != "Sulfuras, Hand of Ragnaros" {
                items[i].sellIn = items[i].sellIn - 1
            }

            if items[i].sellIn < 0 {
                if items[i].name != "Aged Brie" {
                    if items[i].name != "Backstage passes to a TAFKAL80ETC concert" {
                        if items[i].quality > 0 {
                            if items[i].name != "Sulfuras, Hand of Ragnaros" {
                                items[i].updateQuality(difference: -1)
                            }
                        }
                    } else {
                        items[i].quality = 0
                    }
                } else {
                    if items[i].quality < 50 {
                        items[i].updateQuality(difference: 1)
                    }
                }
            }
        }
    }
}

/*
 Kevlin Henney
 https://youtu.be/NMPeAW2RWdc?si=jGAhX7PB6jiorRB_&t=1438

 Feature (what the code does)
 Performance (amount of resources (time, memory, etc..) needed by the code)
 Readability/Maintainability/Scalability

 Feature addition => +Feature, ~=Performance , ~=Readability
 Optimization => =Feature, +Performance , ~=Readability
 Factoring => =Feature, ~=Performance , +Readability
 */

extension Item {
    func updateQuality(difference: Int) {
        quality += difference
    }
}
