import XCTest
import Foundation
import SwiftyJSON

@testable import ShoppingApp

class ProductFeatureResourceTests: XCTestCase {

    func testInitialize_whenHasEmptyJsonData_returnsEmptyValues() {
        let resource: ProductFeatureResource = ProductFeatureResource(json: JSON(Data()))

        XCTAssertEqual(resource.attributeName, "")
        XCTAssertEqual(resource.attributeValue, "")
    }

    func testInitialize_whenHasValidJsonData_returnsMappedValues() {
        let json: JSON = ProductFeatureMother.featureJson()
        let resource: ProductFeatureResource = ProductFeatureResource(json: json)

        XCTAssertEqual(resource.attributeName, "Dimensions")
        XCTAssertEqual(resource.attributeValue, "H84.5cm x W60cm x D60cm")
    }

}
