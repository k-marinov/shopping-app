import XCTest
import Foundation

@testable import ShoppingApp

class ProductsTests: XCTestCase {

    func testInitialize_WhenHasEmptyJsonData_returnsEmptyList() {
        let resource: ProductsResource = ProductsResource(data: Data())
        XCTAssertEqual(resource.products.count, 0)
    }

    func testInitialize_WhenHasValidJsonData_returnsTwoProducts() {
        let resource: ProductsResource = ProductsResource(data: Data())
        XCTAssertEqual(resource.products.count, 2)
    }

}
