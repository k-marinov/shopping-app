import XCTest
import Foundation
import SwiftyJSON

@testable import ShoppingApp

class PriceResourceTests: XCTestCase {

    func testPriceNowFormatted_whenHasEmptyJsonData_returnsEmptyStringValue() {
        let json: JSON = PriceMother.emptyJson()
        let price: PriceResource = PriceResource(json: json)

        XCTAssertEqual(price.priceNowFormatted(), "")
    }

    func testPriceNowFormatted_whenHasEmptyNowValue_returnsEmptyStringValue() {
        let json: JSON = PriceMother.priceWithNowValueEmpty()
        let price: PriceResource = PriceResource(json: json)

        XCTAssertEqual(price.priceNowFormatted(), "")
    }

    func testPriceNowFormatted_whenHasEmptyNowValue_returnsFormattedValue() {
        let json: JSON = PriceMother.priceWithNowValue()
        let price: PriceResource = PriceResource(json: json)

        XCTAssertEqual(price.priceNowFormatted(), "£331.10")
    }

}
