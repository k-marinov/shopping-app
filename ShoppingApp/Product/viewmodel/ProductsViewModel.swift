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

    func loadProducts() -> Observable<Void> {
        return productService.findAllProducts(with: ProductsRequest())
            .observeOn(MainScheduler.instance)
            .do(onNext: { [weak self] newProducts in
               // self?.dataSource.appendOnce(contentsOf: newArticles.sorted { $0.rating > $1.rating })
                }, onError: { [weak self] error in
                    self?.onLoadProductsCompleted(with: error as! ApiError)
                }, onCompleted: {  [weak self] in
                    self?.onLoadProductsCompleted()
                }, onSubscribe: { [weak self] in
                    self?.onLoadProductsStarted()
            }).map { _ in return () }
    }

    private func onLoadProductsStarted() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        isLoading.onNext(true)
    }

    private func onLoadProductsCompleted() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        isLoading.onNext(false)
        reloadData.onNext(())
    }

    private func onLoadProductsCompleted(with error: ApiError) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        isLoading.onNext(false)
    }

}
