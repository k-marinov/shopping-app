import XCTest
import Foundation
import SwiftyJSON

@testable import ShoppingApp

class ProductsTests: XCTestCase {

    func testInitialize_whenHasEmptyJsonData_returnsEmptyList() {
        let resource: ProductsResource = ProductsResource(json: JSON(Data()))

        XCTAssertEqual(resource.products.count, 0)
    }

    func testInitialize_whenHasValidJsonData_returnsThreeProducts() {
        let data: Data = ProductMother.productsJsonData()
        let resource: ProductsResource = ProductsResource(json: JSON(data))

        XCTAssertEqual(resource.products.count, 3)
    }

    func testInitialize_whenHasEmptyProductsJsonData_returnsEmptyList() {
        let data: Data = ProductMother.emptyProductsJsonData()
        let resource: ProductsResource = ProductsResource(json: JSON(data))
        
        XCTAssertEqual(resource.products.count, 0)
    }

}
