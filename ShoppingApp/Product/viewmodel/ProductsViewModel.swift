import RxSwift

class ProductsViewModel: ViewModel {

    private let disposeBag: DisposeBag = DisposeBag()
    private(set) var isLoading: PublishSubject<Bool> = PublishSubject<Bool>()
    private(set) var reloadData: PublishSubject<Int> = PublishSubject<Int>()
    private(set) var dataSource: CollectionViewDataSource<ProductResource, ProductCell> =
        CollectionViewDataSource<ProductResource, ProductCell>()
    private(set) var productService: ProductService
    private(set) var productDetailRouter: ProductDetailRouter!
    private var componentCreatable: ComponentCreatable

    required init(componentCreatable: ComponentCreatable) {
        self.componentCreatable = componentCreatable
        productService = componentCreatable.create(with: componentCreatable)
        productDetailRouter = componentCreatable.create()
        subscribe()
    }

    func subscribe() {
        dataSource.didSelectItemAtIndexPath()
            .map { $0 as! ProductResource }
            .subscribe(onNext: { [weak self] product in
                guard let `self` = self else { return }
                self.productDetailRouter.showProductDetail(componentCreatable: self.componentCreatable, product: product)
            }).disposed(by: disposeBag)
    }

    func loadProducts() -> Observable<Void> {
        return productService.findAllProducts(with: ProductsRequest())
            .observeOn(MainScheduler.instance)
            .do(onNext: { [weak self] newProducts in
                self?.dataSource.appendOnce(contentsOf: newProducts)
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
        reloadData.onNext(dataSource.count())
    }

    private func onLoadProductsCompleted(with error: ApiError) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        isLoading.onNext(false)
    }

}
