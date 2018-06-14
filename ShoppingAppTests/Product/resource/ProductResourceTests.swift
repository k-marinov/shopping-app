import XCTest
import Foundation
import SwiftyJSON

@testable import ShoppingApp

class ProductResourceTests: XCTestCase {

    func testInitialize_WhenHasEmptyJsonData_returnsEmptyValues() {
        let json: JSON = ProductMother.emptyProductJson()
        let product: ProductResource = ProductResource(json: json)

        XCTAssertEqual(product.id, 0)
    }

    func testInitialize_WhenHasValidProductJson_returnsMappedValues() {
        let json: JSON = ProductMother.product3215462Json()
        let product: ProductResource = ProductResource(json: json)

        XCTAssertEqual(product.id, 3215462)
        XCTAssertEqual(product.title, "Bosch SMS25AW00G Freestanding Dishwasher, White")
        XCTAssertEqual(product.imageUrl, "https://johnlewis.scene7.com/is/image/JohnLewis/236888507?")
    }

    func testImageUrl_WhenHasImageUrlWithHttpScheme_doesNotAddHttpsPrefix() {
        let json: JSON = ProductMother.productImageUrlWithHttpScheme()
        let product: ProductResource = ProductResource(json: json)

        XCTAssertEqual(product.imageUrl, "http://johnlewis.com/image/1")
    }

    func testImageUrl_WhenHasImageUrlWithHttpsScheme_doesNotAddHttpsPrefix() {
        let json: JSON = ProductMother.productImageUrlWithHttpsScheme()
        let product: ProductResource = ProductResource(json: json)

        XCTAssertEqual(product.imageUrl, "https://johnlewis.com/image/2")
    }

}
