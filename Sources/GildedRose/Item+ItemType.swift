enum ItemType {
    case agedBrie
    case backstagePass
    case sulfuras
    case conjured
    case regular
}

extension Item {
    var itemType: ItemType {
        if name == "Aged Brie" {
            return .agedBrie
        } else if name.contains("Backstage passes") {
            return .backstagePass
        } else if name.contains("Sulfuras") {
            return .sulfuras
        } else if name.contains("Conjured") {
            return .conjured
        } else {
            return .regular
        }
    }
}
