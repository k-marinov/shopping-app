import OHHTTPStubs

@testable import ShoppingApp

class ProductDetailHttpMocker {

    func setUpStubs() {
        stubHttpResponse(productId: Constants.validProductId, jsonFileName: "product-3215462.json", statusCode: 200)
        stubHttpResponse(productId: Constants.invalidProductId, jsonFileName: "empty.json", statusCode: 404)

        OHHTTPStubs.setEnabled(true)
    }

    func removeStubs() {
        OHHTTPStubs.setEnabled(false)
        OHHTTPStubs.removeAllStubs()
    }

    private func stubHttpResponse(productId: String, jsonFileName: String, statusCode: Int32) {
        stub(condition: { request -> Bool in
            return self.isUrlRequestSuccess(with: request, productId: productId)
        }, response: { _ -> OHHTTPStubsResponse in
            return self.response(jsonFileName: jsonFileName, statusCode: statusCode)
        })
    }

    private func response(jsonFileName: String, statusCode: Int32) -> OHHTTPStubsResponse {
        return OHHTTPStubsResponse(
            fileAtPath: OHPathForFile(jsonFileName, type(of: self))!,
            statusCode: statusCode,
            headers: ["Content-Type": "application/json"])
    }

    private func isUrlRequestSuccess(with urlRequest: URLRequest, productId: String) -> Bool {
        let url: String = urlRequest.url!.absoluteURL.absoluteString
        return url.hasPrefix("https://api.johnlewis.com/v1/products/\(productId)")
    }

}
