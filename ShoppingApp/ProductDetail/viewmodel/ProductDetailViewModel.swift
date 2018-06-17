import RxSwift

class ProductDetailViewModel: ViewModel {

    private(set) var dataSource: CollectionViewDataSource<ProductResource, ProductCell> =
        CollectionViewDataSource<ProductResource, ProductCell>()
    private(set) var productService: ProductService

    required init(componentCreatable: ComponentCreatable, product: ProductResource) {
        productService = componentCreatable.create(with: componentCreatable)
        subscribe()
    }

    func subscribe() {
    }

}
