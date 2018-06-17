import RxSwift

class ProductDetailViewModel: ViewModel {

    private let disposeBag: DisposeBag = DisposeBag()
    private(set) var isLoading: PublishSubject<Bool> = PublishSubject<Bool>()
    private(set) var reloadData: PublishSubject<Int> = PublishSubject<Int>()
    private(set) var publishProductDetail: PublishSubject<ProductResource> = PublishSubject<ProductResource>()
    private(set) var dataSource: CollectionViewDataSource<ProductResource, ProductCell> =
        CollectionViewDataSource<ProductResource, ProductCell>()
    private(set) var productService: ProductService
    private let product: ProductResource

    required init(componentCreatable: ComponentCreatable, product: ProductResource) {
        productService = componentCreatable.create(with: componentCreatable)
        self.product = product
    }

    func loadProductDetail() -> Observable<Void> {
        return productId().flatMap { [weak self] productId -> Observable<Void> in
            guard let `self` = self else { return Observable.empty() }
            return self.productService.findProductDetail(with: try! ProductDetailRequest(productId: productId))
                .observeOn(MainScheduler.instance)
                .do(onNext: { [weak self] newProduct in
                        self?.publishProductDetail.onNext(newProduct)
                    }, onError: { [weak self] error in
                        self?.onProductDetailCompleted(with: error as! ApiError)
                    }, onCompleted: {  [weak self] in
                        self?.onLoadProductDetailCompleted()
                    }, onSubscribe: { [weak self] in
                        self?.onLoadProductDetailStarted()
                }).map { _ in return () }
        }
    }

    private func productId() -> Observable<String> {
        return Observable.create { [weak self] observer in
            guard let `self` = self else { return Disposables.create() }
            if StringUtil.isNilOrEmpty(self.product.id) {
                observer.onCompleted()
            } else {
                observer.onNext(self.product.id)
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }

    private func onLoadProductDetailStarted() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        isLoading.onNext(true)
    }

    private func onLoadProductDetailCompleted() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        isLoading.onNext(false)
        reloadData.onNext(dataSource.count())
    }

    private func onProductDetailCompleted(with error: ApiError) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }

}
