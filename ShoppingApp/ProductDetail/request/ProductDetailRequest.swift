class ProductDetailRequest: ApiRequest {

    private let productId: String

    required init(productId: String) throws {
        self.productId = productId
        try validateStatus()
    }

    func httpRequestUrl() -> String {
        return "https://api.johnlewis.com/v1/products/\(productId)?key=Wu1Xqn3vNrd1p7hqkvB6hEu0G9OrsYGb"
    }

    func httpMethod() -> HttpMethod {
        return HttpMethod.get
    }

    func response(from newResponse: HttpResponse) -> ApiResponse {
        return ApiResponse(
            resourceType: ProductResource.self,
            httpResponse: newResponse,
            successHttpStatusCode: HttpStatusCode.ok)
    }

    func validateStatus() throws {
        if StringUtil.isNilOrEmpty(productId) {
            throw ClassError.invalidArgument
        }
    }

}
