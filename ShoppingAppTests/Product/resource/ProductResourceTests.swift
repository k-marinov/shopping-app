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
    }

}
