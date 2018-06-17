import RxSwift

class ProductDetailViewModel: ViewModel {

    private let disposeBag: DisposeBag = DisposeBag()
    private(set) var isLoading: PublishSubject<Bool> = PublishSubject<Bool>()
    private(set) var reloadImageUrls: PublishSubject<Int> = PublishSubject<Int>()
    private(set) var reloadFeatures: PublishSubject<Void> = PublishSubject<Void>()
    private(set) var publishProductDetail: PublishSubject<ProductResource> = PublishSubject<ProductResource>()

    private(set) var imageUrlsDataSource = CollectionViewDataSource<String, ImageCell>()
    private(set) var imageUrlsDelegate = CollectionViewDelegate()
    private(set) var featuresDataSource = TableViewDataSource<ProductFeatureResource, ProductFeatureCell>()
    private(set) var productService: ProductService
    private let product: ProductResource

    required init(componentCreatable: ComponentCreatable, product: ProductResource) {
        productService = componentCreatable.create(with: componentCreatable)
        self.product = product
    }

    func loadProductDetail() -> Observable<Void> {
        return productId().flatMap { [weak self] productId -> Observable<Void> in
            guard let `self` = self else { return Observable.empty() }
            return self.productService
                .findProductDetail(with: try! ProductDetailRequest(productId: productId))
                .observeOn(MainScheduler.instance)
                .do(onNext: { [weak self] newProduct in
                    self?.onLoadNextProductDetail(product: newProduct)
                    }, onError: { [weak self] error in
                        self?.onProductDetailCompletedWithError()
                    }, onCompleted: {  [weak self] in
                        self?.onLoadProductDetailCompleted()
                    }, onSubscribe: { [weak self] in
                        self?.onLoadProductDetailStarted()
                }).map { _ in return () }
        }
    }

    func selectedPage() -> Observable<Int> {
        return imageUrlsDelegate.selectedPage()
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

    private func onLoadNextProductDetail(product: ProductResource) {
        publishProductDetail.onNext(product)
         publishProductDetail.onCompleted()
        imageUrlsDataSource.appendOnce(contentsOf: product.imageUrls())
        featuresDataSource.appendOnce(contentsOf: product.features())
    }

    private func onLoadProductDetailStarted() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        isLoading.onNext(true)
    }

    private func onLoadProductDetailCompleted() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        isLoading.onNext(false)
        reloadImageUrls.onNext(imageUrlsDataSource.count())
        reloadFeatures.onNext(())
    }

    private func onProductDetailCompletedWithError() {
        isLoading.onNext(false)
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }

}
