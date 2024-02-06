public class GildedRose {
    var items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    // Morgan's Law
    // !A && !B <=> !(A || B)
    fileprivate func updateQuality(of item: Item) {
        let difference: Int

        if item.name == "Aged Brie" {
            if item.sellIn > 0 {
                difference = 1
            } else {
                difference = 2
            }
        } else if item.name == "Backstage passes to a TAFKAL80ETC concert" {
            if item.sellIn > 10 {
                difference = 1
            } else if item.sellIn > 5 {
                difference = 2
            } else if item.sellIn > 0 {
                difference = 3
            } else {
                difference =  -item.quality
            }
        } else if item.name == "Sulfuras, Hand of Ragnaros" {
            difference = 0
        } else if item.name == "Conjured" {
            if item.sellIn > 0 {
                difference = -2
            } else {
                difference = -4
            }
        } else {
            if item.sellIn > 0 {
                difference = -1
            } else {
                difference = -2
            }
        }

        if difference != 0 {
            item.updateQuality(difference: difference)
            item.sellIn = item.sellIn - 1
        }
    }

    public func updateQuality() {
        items.forEach(updateQuality(of:))
    }
}

extension Item {
    func updateQuality(difference: Int) {
        /*
        // 0 < Q < 50
        // clamp(x, min, max) -> x such that x < min && x > max
        var newQuality = quality + difference

        newQuality = min(50, newQuality) // will never exceed 50
        newQuality = max(0, newQuality) // will never drops below 0

        quality = newQuality
        */

        quality = max(0, min(50, quality + difference))
    }
}
