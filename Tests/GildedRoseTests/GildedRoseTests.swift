@testable import GildedRose
import XCTest

class GildedRoseTests: XCTestCase {
    func testRegularItem() {
        assertItemUpdate(
            Item(name: "Regular Item", sellIn: 10, quality: 10),
            expectedQuality: 9,
            expectedSellIn: 9
        )
    }

    func testRegularItemWithQualityIs0() {
        assertItemUpdate(
            Item(name: "Regular Item", sellIn: 10, quality: 0),
            expectedQuality: 0,
            expectedSellIn: 9
        )
    }

    func testRegularItemWithSellInLessThan0() {
        assertItemUpdate(
            Item(name: "Regular Item", sellIn: 0, quality: 10),
            expectedQuality: 8,
            expectedSellIn: -1
        )
    }

    func testAgedBrie() {
        assertItemUpdate(
            Item(name: "Aged Brie", sellIn: 10, quality: 10),
            expectedQuality: 11,
            expectedSellIn: 9
        )
    }

    func testAgedBrieWithQualityIs50() {
        assertItemUpdate(
            Item(name: "Aged Brie", sellIn: 10, quality: 50),
            expectedQuality: 50,
            expectedSellIn: 9
        )
    }

    func testAgedBrieWithSellInLessThan0() {
        assertItemUpdate(
            Item(name: "Aged Brie", sellIn: 0, quality: 10),
            expectedQuality: 12,
            expectedSellIn: -1
        )
    }

    func testBackstagePass() {
        assertItemUpdate(
            Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 20, quality: 10),
            expectedQuality: 11,
            expectedSellIn: 19
        )
    }

    func testBackstagePassIsLessThan11() {
        assertItemUpdate(
            Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 10, quality: 10),
            expectedQuality: 12,
            expectedSellIn: 9
        )
        assertItemUpdate(
            Item(name: "Backstage passes to a Shenanigan concert", sellIn: 10, quality: 10),
            expectedQuality: 12,
            expectedSellIn: 9
        )
    }

    func testBackstagePassWithSellInLessThan0() {
        assertItemUpdate(
            Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 0, quality: 10),
            expectedQuality: 0,
            expectedSellIn: -1
        )
        assertItemUpdate(
            Item(name: "Backstage passes to a Shenanigan concert", sellIn: 0, quality: 10),
            expectedQuality: 0,
            expectedSellIn: -1
        )
    }

    func testBackstagePassWithSellInLessThan6() {
        assertItemUpdate(
            Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 5, quality: 10),
            expectedQuality: 13,
            expectedSellIn: 4
        )
        assertItemUpdate(
            Item(name: "Backstage passes to a Shenanigan concert", sellIn: 5, quality: 10),
            expectedQuality: 13,
            expectedSellIn: 4
        )
    }

    func testSulfuras() {
        assertItemUpdate(
            Item(name: "Sulfuras, Hand of Ragnaros", sellIn: 5, quality: 80),
            expectedQuality: 80,
            expectedSellIn: 5
        )
    }

    func testConjuredItem() {
        assertItemUpdate(
            Item(name: "Conjured", sellIn: 5, quality: 10),
            expectedQuality: 8,
            expectedSellIn: 4
        )
    }

    func testConjuredItemWithSellInLessThan0() {
        assertItemUpdate(
            Item(name: "Conjured", sellIn: -1, quality: 10),
            expectedQuality: 6,
            expectedSellIn: -2
        )
    }

    private func assertItemUpdate(
        _ item: Item,
        expectedQuality: Int,
        expectedSellIn: Int
    ) {
        let app = GildedRose(items: [item])
        app.updateQuality()

        XCTAssertEqual(app.items[0].quality, expectedQuality)
        XCTAssertEqual(app.items[0].sellIn, expectedSellIn)
    }

    func testItemClamp50() {
        let item = Item(name: "Any", sellIn: 10, quality: 48)

        item.updateQuality(difference: 5)

        XCTAssertEqual(item.quality, 50)
    }

    func testItemClamp0() {
        let item = Item(name: "Any", sellIn: 10, quality: 10)

        item.updateQuality(difference: -15)

        XCTAssertEqual(item.quality, 0)
    }

    func testItemClampMiddle() {
        let item = Item(name: "Any", sellIn: 10, quality: 30)

        item.updateQuality(difference: 5)

        XCTAssertEqual(item.quality, 35)
    }

    func testItemType() {
        let items = [
            Item(name: "Any Item", sellIn: 10, quality: 10),
            Item(name: "Aged Brie", sellIn: 10, quality: 10),
            Item(name: "Backstage passes to something", sellIn: 10, quality: 10),
            Item(name: "Sulfuras, item of chaos", sellIn: 10, quality: 10),
            Item(name: "Conjured banana sword", sellIn: 10, quality: 10)
        ]

        XCTAssertEqual(items[0].itemType, .regular)
        XCTAssertEqual(items[1].itemType, .agedBrie)
        XCTAssertEqual(items[2].itemType, .backstagePass)
        XCTAssertEqual(items[3].itemType, .sulfuras)
        XCTAssertEqual(items[4].itemType, .conjured)
    }
}
