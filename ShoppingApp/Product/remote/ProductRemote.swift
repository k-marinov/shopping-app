import RxSwift

class ProductRemote {

    private let apiClient: ApiClient

    required init(componentCreatable: ComponentCreatable) {
        apiClient = componentCreatable.create(with: componentCreatable)
    }

    func findAllProducts(with request: ProductsRequest) -> Observable<[ProductResource]> {
        return apiClient.request(with: request)
            .map { ($0.resource as! ProductsResource).products }
    }

}
