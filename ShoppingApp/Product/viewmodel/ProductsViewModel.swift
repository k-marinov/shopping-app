import RxSwift

class ProductsViewModel: ViewModel {

    private(set) var isLoading: PublishSubject<Bool> = PublishSubject<Bool>()
    private(set) var reloadData: PublishSubject<Void> = PublishSubject<Void>()
    private(set) var productService: ProductService

    required init(componentCreatable: ComponentCreatable) {
        productService = componentCreatable.create(with: componentCreatable)
        subscribe()
    }

    func subscribe() {

    }

}
