import XCTest
import Foundation
import SwiftyJSON

@testable import ShoppingApp

class ProductResourceTests: XCTestCase {

    func testInitialize_whenHasEmptyJsonData_returnsEmptyValues() {
        let json: JSON = ProductMother.emptyProductJson()
        let product: ProductResource = ProductResource(json: json)

        XCTAssertEqual(product.id, 0)
        XCTAssertEqual(product.title, "")
        XCTAssertNil(product.imageUrl)
        XCTAssertEqual(product.code, "")
        XCTAssertEqual(product.priceNowFormatted(), "")
        XCTAssertEqual(product.information(), "")
        XCTAssertEqual(product.includedServicesFormatted(), "")
        XCTAssertTrue(product.features().isEmpty)
        XCTAssertTrue(product.imageUrls().isEmpty)
    }

    func testInitialize_whenHasValidProductJson_returnsMappedValues() {
        let json: JSON = ProductMother.product3215462Json()
        let product: ProductResource = ProductResource(json: json)

        XCTAssertEqual(product.id, 3215462)
        XCTAssertEqual(product.title, "Bosch SMS25AW00G Freestanding Dishwasher, White")
        XCTAssertEqual(product.imageUrl, "https://johnlewis.scene7.com/is/image/JohnLewis/236888507?")
        XCTAssertEqual(product.displaySpecialOffer, "buy 1 free get 1 free")
        XCTAssertEqual(product.code, "81701107")
        XCTAssertEqual(product.priceNowFormatted(), "£349.00")
        XCTAssertEqual(product.information(), "<p>Reliable and versatile, the Freestanding Dishwasher from Bosch</p>")
        XCTAssertEqual(product.includedServicesFormatted(), "2 year guarantee included, 1 month free service")
        XCTAssertEqual(product.features().count, 4)
        XCTAssertEqual(product.imageUrls().count, 4)
    }

}
