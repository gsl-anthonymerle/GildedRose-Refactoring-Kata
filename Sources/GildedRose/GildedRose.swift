struct Rule {
    let match: String
    let qualityDifference: (Item) -> Int
}

public class GildedRose {
    var items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    let rules: [Rule] = [
        Rule(match: "Aged Brie", qualityDifference: { item in
            item.sellIn > 0 ? 1 : 2
        }),
        Rule(match: "Backstage passes to a TAFKAL80ETC concert", qualityDifference: { item in
            if item.sellIn > 10 {
                return 1
            } else if item.sellIn > 5 {
                return 2
            } else if item.sellIn > 0 {
                return 3
            } else {
                return -item.quality
            }
        }),
        Rule(match: "Sulfuras, Hand of Ragnaros", qualityDifference: { _ in 0 }),
        Rule(match: "Conjured", qualityDifference: { item in
            item.sellIn > 0 ? -2 : -4
        })
    ]
    
    // Morgan's Law
    // !A && !B <=> !(A || B)
    fileprivate func updateQuality(of item: Item) {
        let difference: Int

        if let rule = rules.first(where: { item.name == $0.match }) {
            difference = rule.qualityDifference(item)
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
