import XCTest
import Foundation
import SwiftyJSON

@testable import ShoppingApp

class ApiResponseTests: XCTestCase {

    func testApiFailError_whenHasStatusCode400_returnsApiErrorClient() {
        let response: ApiResponse = ApiResponse(
            resourceType: ProductsResource.self,
            httpResponse: HttpResponseMother.createEmptyHttpResponse(withStatusCode: 400),
            successHttpStatusCode: HttpStatusCode.ok)

        XCTAssertEqual(response.apiFailError(), ApiError.client)
    }

    func testApiFailError_whenHasStatusCode500_returnsApiErrorServer() {
        let response: ApiResponse = ApiResponse(
            resourceType: ProductsResource.self,
            httpResponse: HttpResponseMother.createEmptyHttpResponse(withStatusCode: 500),
            successHttpStatusCode: HttpStatusCode.ok)

        XCTAssertEqual(response.apiFailError(), ApiError.server)
    }

    func testApiFailError_whenHasInvalidStatusCode_returnsApiErrorUnknown() {
        let response: ApiResponse = ApiResponse(
            resourceType: ProductsResource.self,
            httpResponse: HttpResponseMother.createEmptyHttpResponse(withStatusCode: -100),
            successHttpStatusCode: HttpStatusCode.ok)

        XCTAssertEqual(response.apiFailError(), ApiError.unknown)
    }

}
