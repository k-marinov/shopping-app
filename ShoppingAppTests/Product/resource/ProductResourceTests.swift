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
        XCTAssertEqual(product.imageUrl, "")
        XCTAssertEqual(product.priceNowFormatted(), "")
    }

    func testInitialize_whenHasValidProductJson_returnsMappedValues() {
        let json: JSON = ProductMother.product3215462Json()
        let product: ProductResource = ProductResource(json: json)

        XCTAssertEqual(product.id, 3215462)
        XCTAssertEqual(product.title, "Bosch SMS25AW00G Freestanding Dishwasher, White")
        XCTAssertEqual(product.imageUrl, "https://johnlewis.scene7.com/is/image/JohnLewis/236888507?")
        XCTAssertEqual(product.priceNowFormatted(), "£349.00")
    }

    func testImageUrl_whenHasImageUrlWithHttpScheme_doesNotAddHttpsPrefix() {
        let json: JSON = ProductMother.productImageUrlWithHttpScheme()
        let product: ProductResource = ProductResource(json: json)

        XCTAssertEqual(product.imageUrl, "http://johnlewis.com/image/1")
    }

    func testImageUrl_whenHasImageUrlWithHttpsScheme_doesNotAddHttpsPrefix() {
        let json: JSON = ProductMother.productImageUrlWithHttpsScheme()
        let product: ProductResource = ProductResource(json: json)

        XCTAssertEqual(product.imageUrl, "https://johnlewis.com/image/2")
    }

}
