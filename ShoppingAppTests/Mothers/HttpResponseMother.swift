import Foundation

@testable import ShoppingApp

class HttpResponseMother {

    class func httpResponse(withStatusCode statusCode: Int) -> HttpResponse {
        let response: HTTPURLResponse? = HTTPURLResponse(
            url: URL(string: "http://johnlewis.com")!,
            statusCode: statusCode,
            httpVersion: "1.0",
            headerFields: nil)
        let value: Data = "{}".data(using: String.Encoding.utf8)!
        return HttpResponse(response: response, data: value, error: NSError(domain: "", code: 0, userInfo: nil))
    }

    class func emptyHttpResponse(withStatusCode statusCode: Int) -> HttpResponse {
        let response: HTTPURLResponse? = HTTPURLResponse(
            url: URL(string: "http://johnlewis.com")!,
            statusCode: statusCode,
            httpVersion: "1.0",
            headerFields: nil)
        let value: Data = "".data(using: String.Encoding.utf8)!
        return HttpResponse(response: response, data: value, error: NSError(domain: "", code: 0, userInfo: nil))
    }

}
