struct Rule {
    let match: ItemType
    let qualityDifference: (Item) -> Int
}

public class GildedRose {
    var items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    let rules: [Rule] = [
        Rule(match: .regular, qualityDifference: { item in
            item.sellIn > 0 ? -1 : -2
        }),
        Rule(match: .agedBrie, qualityDifference: { item in
            item.sellIn > 0 ? 1 : 2
        }),
        // Any item which name starts with "Backstage passes"
        Rule(match: .backstagePass, qualityDifference: { item in
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
        // Any item which name starts with "Sulfuras"
        Rule(match: .sulfuras, qualityDifference: { _ in 0 }),
        Rule(match: .conjured, qualityDifference: { item in
            item.sellIn > 0 ? -2 : -4
        })
    ]
    
    fileprivate func updateQuality(of item: Item) {
        guard let rule = rules.first(where: { item.itemType == $0.match }) else {
            return
        }

        let difference = rule.qualityDifference(item)

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
