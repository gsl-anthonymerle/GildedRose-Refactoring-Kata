enum ItemType: String {
    case agedBrie = "Aged Brie"
    case backstagePass = "Backstage passes to a TAFKAL80ETC concert"
    case sulfuras = "Sulfuras, Hand of Ragnaros"
    case regular
}

public class GildedRose {
    var items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    // add tests
    // using filters

    public func updateQuality() {
//        items.filter { item in
//            item.name != "Aged Brie" && item.name != "Backstage passes to a TAFKAL80ETC concert"
//        }
//        .filter { item in
//            item.quality > 0
//        }


        for i in 0 ..< items.count {
            if items[i].itemType != .agedBrie, items[i].itemType != .backstagePass {
                if items[i].quality > 0 {
                    if items[i].itemType != .sulfuras {
                        items[i].updateQuality(difference: -1)
                    }
                }
            } else {
                if items[i].quality < 50 {
                    items[i].updateQuality(difference: 1)

                    if items[i].itemType == .backstagePass {
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

            if items[i].itemType != .sulfuras {
                items[i].sellIn = items[i].sellIn - 1
            }

            if items[i].sellIn < 0 {
                if items[i].itemType != .agedBrie {
                    if items[i].itemType != .backstagePass {
                        if items[i].quality > 0 {
                            if items[i].itemType != .sulfuras {
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

    var itemType: ItemType {
        ItemType(rawValue: self.name) ?? .regular
    }
}
