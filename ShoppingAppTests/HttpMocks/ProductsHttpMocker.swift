import OHHTTPStubs

@testable import ShoppingApp

class ProductsHttpMocker {

    func setUpStubs() {
        stubHttpResponse(apiKey: Constants.validApiKey, jsonFileName: "products.json", statusCode: 200)
        stubHttpResponse(apiKey: Constants.invalidApiKey, jsonFileName: "empty.json", statusCode: 401)

        OHHTTPStubs.setEnabled(true)
    }

    func removeStubs() {
        OHHTTPStubs.setEnabled(false)
        OHHTTPStubs.removeAllStubs()
    }

    private func stubHttpResponse(apiKey: String, jsonFileName: String, statusCode: Int32) {
        stub(condition: { request -> Bool in
            return self.isUrlRequestSuccess(with: request, apiKey: apiKey)
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

    private func isUrlRequestSuccess(with urlRequest: URLRequest, apiKey: String) -> Bool {
        let url: String = urlRequest.url!.absoluteURL.absoluteString
        return url.hasPrefix("https://api.johnlewis.com/v1/products/") && url.contains(apiKey)
    }

}
