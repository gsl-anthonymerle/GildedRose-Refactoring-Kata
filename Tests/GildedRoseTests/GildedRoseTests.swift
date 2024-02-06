@testable import GildedRose
import XCTest

/*

 Once the sell by date has passed, Quality degrades twice as fast
 The Quality of an item is never negative
 "Aged Brie" actually increases in Quality the older it gets
 The Quality of an item is never more than 50
 "Sulfuras", being a legendary item, never has to be sold or decreases in Quality
 "Backstage passes", like aged brie, increases in Quality as its SellIn value approaches;
 Quality increases by 2 when there are 10 days or less and by 3 when there are 5 days or less but
 Quality drops to 0 after the concert

 */

// Don't beleive in a test that you never have seen failed

class GildedRoseTests: XCTestCase {
    // sut = System Under Test
    var sut: GildedRose!

    override func setUp() {
        let items = [
            Item(name: "Regular Item", sellIn: 10, quality: 10),
            Item(name: "Aged Brie", sellIn: 10, quality: 10),
            Item(name: "Sulfuras, Hand of Ragnaros", sellIn: 10, quality: 10),
            Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 10, quality: 10),
            Item(name: "Regular Item", sellIn: 10, quality: 0),
            Item(name: "Aged Brie", sellIn: 10, quality: 50),
            Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 0, quality: 10)
        ]

        sut = GildedRose(items: items)
    }

    override func tearDown() {
        sut = nil
    }

    func testRegularItem() {
        sut.updateQuality()

        XCTAssertEqual(sut.items[0].sellIn, 9)
        XCTAssertEqual(sut.items[0].quality, 9)
    }

    func testAgedBrie() {
    }

    func testBackstagePass() {
    }

    func testSulfuras() {
    }
}
