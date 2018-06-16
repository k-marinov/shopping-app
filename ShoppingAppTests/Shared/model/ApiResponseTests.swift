import XCTest

@testable import ShoppingApp

class ApiResponseTests: XCTestCase {

    func testApiFailError_whenHasStatusCode400_returnsApiErrorClient() {
        let response: ApiResponse = ApiResponse(
            resourceType: ProductsResource.self,
            httpResponse: HttpResponseMother.emptyHttpResponse(withStatusCode: 400),
            successHttpStatusCode: HttpStatusCode.ok)

        XCTAssertEqual(response.apiFailError(), ApiError.client)
    }

    func testApiFailError_whenHasStatusCode500_returnsApiErrorServer() {
        let response: ApiResponse = ApiResponse(
            resourceType: ProductsResource.self,
            httpResponse: HttpResponseMother.emptyHttpResponse(withStatusCode: 500),
            successHttpStatusCode: HttpStatusCode.ok)

        XCTAssertEqual(response.apiFailError(), ApiError.server)
    }

    func testApiFailError_whenHasInvalidStatusCode_returnsApiErrorUnknown() {
        let response: ApiResponse = ApiResponse(
            resourceType: ProductsResource.self,
            httpResponse: HttpResponseMother.emptyHttpResponse(withStatusCode: -100),
            successHttpStatusCode: HttpStatusCode.ok)

        XCTAssertEqual(response.apiFailError(), ApiError.unknown)
    }

}
