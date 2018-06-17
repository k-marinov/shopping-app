import XCTest

@testable import ShoppingApp

class ProductDetailRequestTests: XCTestCase {

    func testIntializer_whenHasEmptyProductId_throwsClassErrorInvalidArgument() {
        XCTAssertThrowsError(try ProductDetailRequest(productId: "")) { error -> Void in
            XCTAssertEqual((error as! ClassError), ClassError.invalidArgument)
        }
    }

    func testHttpRequestUrl_whenHasValue_returnsUrl() {
        let expectedUrl: String = "https://api.johnlewis.com/v1/products/3215462?key=Wu1Xqn3vNrd1p7hqkvB6hEu0G9OrsYGb"
        XCTAssertEqual(try! ProductDetailRequest(productId: "3215462").httpRequestUrl(), expectedUrl)
    }

    func testHttpMethod_whenHasValue_returnsHttpMethodGet() {
        XCTAssertEqual(try! ProductDetailRequest(productId: "3215462").httpMethod(), HttpMethod.get)
    }

    func testResource_whenHasValidData_returnsProductsResource() {
        let httpResponse: HttpResponse = HttpResponseMother.httpResponse(withStatusCode: 200)
        let response: ApiResponse = try! ProductDetailRequest(productId: "3215462").response(from: httpResponse)

        XCTAssertTrue(response.resource is ProductResource)
    }

    func testResource_whenHasEmptyData_returnsNil() {
        let httpResponse: HttpResponse = HttpResponseMother.emptyHttpResponse(withStatusCode: 200)
        let response: ApiResponse = try! ProductDetailRequest(productId: "3215462").response(from: httpResponse)

        XCTAssertNil(response.resource)
    }

    func testIsSuccess_whenHttpResponseCodeIsEqualToSuccessCode_returnsTrue() {
        let httpResponse: HttpResponse = HttpResponseMother.emptyHttpResponse(withStatusCode: 200)
        let response: ApiResponse = try! ProductDetailRequest(productId: "3215462").response(from: httpResponse)

        XCTAssertTrue(response.isSuccess())
    }

    func testIsSuccess_whenHasStatusCode200_returnsTrue() {
        let httpResponse: HttpResponse = HttpResponseMother.emptyHttpResponse(withStatusCode: 200)
        let response: ApiResponse = try! ProductDetailRequest(productId: "3215462").response(from: httpResponse)

        XCTAssertTrue(response.isSuccess())
    }

    func testIsSuccess_whenHasStatusCode401_returnsTrue() {
        let httpResponse: HttpResponse = HttpResponseMother.emptyHttpResponse(withStatusCode: 401)
        let response: ApiResponse = try! ProductDetailRequest(productId: "3215462").response(from: httpResponse)

        XCTAssertFalse(response.isSuccess())
    }

}
