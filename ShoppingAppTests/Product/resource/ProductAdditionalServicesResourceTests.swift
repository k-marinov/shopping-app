import XCTest
import Foundation
import SwiftyJSON

@testable import ShoppingApp

class ProductAdditionalServiceResourceTests: XCTestCase {

    func testIncludedServicesFormatted_whenHasEmptyJsonData_returnsEmptyString() {
        let resource = ProductAdditionalServicesResource(json: JSON(Data()))

        XCTAssertEqual(resource.includedServicesFormatted(), "")
    }

    func testIncludedServicesFormatted_whenValidJsonData_returnsValue() {
        let json: JSON = ProductAdditionalServicesMother.additionalServicesJson()
        let resource = ProductAdditionalServicesResource(json: json)

        XCTAssertEqual(resource.includedServicesFormatted(), "2 year guarantee included, 1 month free service")
    }

    func testIncludedServicesFormatted_whenEmptyStringServices_returnsEmpty() {
        let json: JSON = ProductAdditionalServicesMother.additionalServicesEmptyStringsJson()
        let resource = ProductAdditionalServicesResource(json: json)

        XCTAssertEqual(resource.includedServicesFormatted(), "")
    }

}
