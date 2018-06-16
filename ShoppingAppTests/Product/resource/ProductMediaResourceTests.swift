import XCTest
import Foundation
import SwiftyJSON

@testable import ShoppingApp

class ProductMediaResourceTests: XCTestCase {

    func testInitialize_whenHasEmptyJsonData_returnsEmptyUrls() {
        let resource: ProductMediaResource = ProductMediaResource(json: JSON(Data()))

        XCTAssertTrue(resource.imageUrls.isEmpty)
    }

    func testInitialize_whenHasValidJsonData_returnsImageUrls() {
        let json: JSON = ProductMediaMother.mediaJson()
        let resource: ProductMediaResource = ProductMediaResource(json: json)

        XCTAssertEqual(resource.imageUrls.count, 4)
        XCTAssertEqual(resource.imageUrls, ProductMediaMother.expectedImageUrls())
    }

}
