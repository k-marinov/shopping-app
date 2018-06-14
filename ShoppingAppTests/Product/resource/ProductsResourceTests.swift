import XCTest
import Foundation

@testable import ShoppingApp

class ProductsTests: XCTestCase {

    func testInitialize_WhenHasEmptyJsonData_returnsEmptyList() {
        let resource: ProductsResource = ProductsResource(data: Data())
        XCTAssertEqual(resource.products.count, 0)
    }

    func testInitialize_WhenHasValidJsonData_returnsThreeProducts() {
        let data: Data = ProductMother.createProductsJsonData()
        let resource: ProductsResource = ProductsResource(data: data)
        XCTAssertEqual(resource.products.count, 3)
    }

    func testInitialize_WhenHasEmptyProductsJsonData_returnsEmptyList() {
        let data: Data = ProductMother.createEmptyProductsJsonData()
        let resource: ProductsResource = ProductsResource(data: data)
        XCTAssertEqual(resource.products.count, 0)
    }

}
