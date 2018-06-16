import XCTest
import Foundation
import SwiftyJSON

@testable import ShoppingApp

class ProductsRequestTests: XCTestCase {

    func testHttpRequestUrl_whenHasValue_returnsUrl() {
        let expectedUrl: String = "https://api.johnlewis.com/v1/products/search?"
            + "q=dishwasher&key=Wu1Xqn3vNrd1p7hqkvB6hEu0G9OrsYGb&pageSize=20"
        XCTAssertEqual(ProductsRequest().httpRequestUrl(), expectedUrl)
    }

}
