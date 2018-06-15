import XCTest
import Foundation
import SwiftyJSON

@testable import ShoppingApp

class ProductDetailsResourceTests: XCTestCase {

    func testInitialize_whenHasEmptyJsonData_returnsEmptyValues() {
        let resource: ProductDetailsResource = ProductDetailsResource(json: JSON(Data()))

        XCTAssertEqual(resource.information, "")
        XCTAssertTrue(resource.features.isEmpty)
    }

    func testInitialize_whenHasValidJsonData_returnsMappedValues() {
        let json: JSON = ProductDetailsMother.productDetails3215462Json()
        let resource: ProductDetailsResource = ProductDetailsResource(json: json)
        let expectedInformation: String = ProductDetailsMother().productInformation3215462

        XCTAssertEqual(resource.information, expectedInformation)
        XCTAssertEqual(resource.features.count, 4)
        XCTAssertEqual(resource.features[0].attributeName, "Salt Level Indicator")
        XCTAssertEqual(resource.features[0].attributeValue, "YES")
        XCTAssertEqual(resource.features[3].attributeName, "Wash performance")
        XCTAssertEqual(resource.features[3].attributeValue, "A")
    }

}
