import XCTest

@testable import ShoppingApp

class ApiRequestTests: XCTestCase {

    func testAsURLRequest_whenHasInvalidUrl_throwsApiRequestError() {
        let request: MockProductsRequest = MockProductsRequest(url: "ahrotro:***>$$£$%$5", method: HttpMethod.get)
        XCTAssertThrowsError(try request.asURLRequest()) { error -> Void in
            let apiRequestError: ApiRequestError = ApiRequestError.invalidUrl(
                "can not create URL invalid with httpRequestUrl=ahrotro:***>$$£$%$5")
            XCTAssertEqual((error as! ApiRequestError), apiRequestError)
        }
    }

    func testAsURLRequest_whenValidUrl_returnsURLRequest() {
        let request: MockProductsRequest = MockProductsRequest(url: "http://johnlewis.com/product/1", method: HttpMethod.get)
        let contentTypeHeaderValue: String? = try! request.asURLRequest().allHTTPHeaderFields?["Content-Type"]
        let httpMethod: String? = try! request.asURLRequest().httpMethod
        let cachePolicy: URLRequest.CachePolicy = try! request.asURLRequest().cachePolicy
        let timeoutInterval: TimeInterval = try! request.asURLRequest().timeoutInterval

        XCTAssertEqual(contentTypeHeaderValue, "application/json")
        XCTAssertEqual(httpMethod, "GET")
        XCTAssertEqual(cachePolicy, URLRequest.CachePolicy.reloadIgnoringLocalCacheData)
        XCTAssertEqual(timeoutInterval, 30)
    }

}
