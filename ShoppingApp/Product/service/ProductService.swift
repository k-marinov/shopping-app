import RxSwift

class ProductService: Service {

    private var productRemote: ProductRemote

    required init(componentCreatable: ComponentCreatable) {
        productRemote = componentCreatable.create(with: componentCreatable)
    }

    func findAllProducts(with request: ProductsRequest) -> Observable<[ProductResource]> {
        return productRemote.findAllProducts(with:request)
    }
}
