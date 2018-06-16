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

    func testHttpMethod_whenHasValue_returnsHttpMethodGet() {
        XCTAssertEqual(ProductsRequest().httpMethod(), HttpMethod.get)
    }

    func testResource_whenHasValidData_returnsProductsResource() {
        let httpResponse: HttpResponse = HttpResponseMother.createHttpResponse(withStatusCode: 200)
        let response: ApiResponse = ProductsRequest().response(from: httpResponse)

        XCTAssertTrue(response.resource is ProductsResource)
    }

    func testResource_whenHasEmptyData_returnsNil() {
        let httpResponse: HttpResponse = HttpResponseMother.createEmptyHttpResponse(withStatusCode: 200)
        let response: ApiResponse = ProductsRequest().response(from: httpResponse)

        XCTAssertNil(response.resource)
    }

}
