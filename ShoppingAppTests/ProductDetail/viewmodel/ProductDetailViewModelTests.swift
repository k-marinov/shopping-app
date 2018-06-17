import XCTest
import RxSwift

@testable import ShoppingApp

class ProductDetailViewModelTests: XCTestCase {

    private let disposeBag: DisposeBag = DisposeBag()
    private let creator: MockComponentCreator = MockComponentCreator.buildAllMocks()
    private var viewModel: ProductDetailViewModel!
    private var isLoadingCollector: RxCollector<Bool>!
    private var reloadImageUrlsCollector: RxCollector<Int>!
    private var reloadFeaturesCollector: RxCollector<Void>!
    private var publishProductDetailCollector: RxCollector<ProductResource>!
    private let product: ProductResource = ProductMother.createProducts().products[0]
    private var collectionView: UICollectionView!


    override func setUp() {
        super.setUp()
        viewModel = ProductDetailViewModel(componentCreatable: creator, product: product)
        isLoadingCollector = RxCollector<Bool>().collect(from: viewModel.isLoading.asObservable())
        reloadImageUrlsCollector = RxCollector<Int>().collect(from: viewModel.reloadImageUrls.asObservable())
        reloadFeaturesCollector = RxCollector<Void>().collect(from: viewModel.reloadFeatures.asObservable())
        publishProductDetailCollector = RxCollector<ProductResource>()
            .collect(from: viewModel.publishProductDetail.asObservable())
    }

    func testLoadProducts_whenHasEmptyProductId_doesNotMakeRequest() {
        creator.mockProductService().isFindProductDetailRequestSuccess = true
        let viewModel = ProductDetailViewModel(
            componentCreatable: creator,
            product: ProductMother.productWithEmptyId())

        isLoadingCollector = RxCollector<Bool>().collect(from: viewModel.isLoading.asObservable())
        reloadImageUrlsCollector = RxCollector<Int>().collect(from: viewModel.reloadImageUrls.asObservable())
        reloadFeaturesCollector = RxCollector<Void>().collect(from: viewModel.reloadFeatures.asObservable())
        publishProductDetailCollector = RxCollector<ProductResource>()
            .collect(from: viewModel.publishProductDetail.asObservable())

        let expectation = self.expectation(description: "")
        viewModel.loadProductDetail()
            .subscribe(onNext: {
                XCTFail()
            }, onError: { error in
                XCTFail()
            }, onCompleted: {
                expectation.fulfill()
            }).disposed(by: disposeBag)
        wait(for: [expectation], timeout: Constants.timeout)

        XCTAssertTrue(isLoadingCollector.results.isEmpty)
        XCTAssertTrue(reloadImageUrlsCollector.results.isEmpty)
        XCTAssertTrue(reloadFeaturesCollector.results.isEmpty)
        XCTAssertTrue(publishProductDetailCollector.results.isEmpty)
    }

    func testLoadProductDetail_whenSuccess_updatesUi() {
        creator.mockProductService().isFindProductDetailRequestSuccess = true
        resetCollectors()

        let expectation = self.expectation(description: "")
        viewModel.loadProductDetail()
            .subscribe(onError: { error in
                expectation.fulfill()
            }, onCompleted: {
                expectation.fulfill()
            }).disposed(by: disposeBag)
        wait(for: [expectation], timeout: Constants.timeout)

        XCTAssertFalse(isLoadingCollector.results.isEmpty)
        XCTAssertEqual(isLoadingCollector.results, [true, false])
        XCTAssertEqual(reloadImageUrlsCollector.results.count, 1)
        XCTAssertEqual(reloadImageUrlsCollector.results[0], 4)
        XCTAssertEqual(reloadFeaturesCollector.results.count, 1)
    }

    func testLoadProductDetail_whenFails_updatesUi() {
        creator.mockProductService().isFindProductDetailRequestSuccess = false
        resetCollectors()

        let expectation = self.expectation(description: "")
        viewModel.loadProductDetail()
            .subscribe(onError: { error in
                expectation.fulfill()
            }, onCompleted: {
                expectation.fulfill()
            }).disposed(by: disposeBag)
        wait(for: [expectation], timeout: Constants.timeout)

        XCTAssertFalse(isLoadingCollector.results.isEmpty)
        XCTAssertEqual(isLoadingCollector.results, [true, false])
        XCTAssertTrue(reloadImageUrlsCollector.results.isEmpty)
        XCTAssertTrue(reloadFeaturesCollector.results.isEmpty)
    }

    func testLoadProductDetail_whenSuccess_appendsToDataSource() {
        creator.mockProductService().isFindProductDetailRequestSuccess = true
        resetCollectors()

        let expectation = self.expectation(description: "")
        viewModel.loadProductDetail()
            .subscribe(onError: { error in
                expectation.fulfill()
            }, onCompleted: {
                expectation.fulfill()
            }).disposed(by: disposeBag)
        wait(for: [expectation], timeout: Constants.timeout)

        XCTAssertEqual(viewModel.imageUrlsDataSource.count(), 4)
        XCTAssertEqual(viewModel.featuresDataSource.count(), 4)
    }

    func testLoadProductDetail_whenFails_doesNotAppendToDataSource() {
        creator.mockProductService().isFindProductDetailRequestSuccess = false
        resetCollectors()

        let expectation = self.expectation(description: "")
        viewModel.loadProductDetail()
            .subscribe(onError: { error in
                expectation.fulfill()
            }, onCompleted: {
                expectation.fulfill()
            }).disposed(by: disposeBag)
        wait(for: [expectation], timeout: Constants.timeout)

        XCTAssertEqual(viewModel.imageUrlsDataSource.count(), 0)
        XCTAssertEqual(viewModel.featuresDataSource.count(), 0)
    }

    func testLoadProductDetail_whenSuccess_publishesProductDetail() {
        creator.mockProductService().isFindProductDetailRequestSuccess = true
        resetCollectors()

        let expectation = self.expectation(description: "")
        viewModel.loadProductDetail()
            .subscribe(onError: { error in
                expectation.fulfill()
            }, onCompleted: {
                expectation.fulfill()
            }).disposed(by: disposeBag)
        wait(for: [expectation], timeout: Constants.timeout)

        XCTAssertEqual(publishProductDetailCollector.results.count, 1)
        XCTAssertEqual(publishProductDetailCollector.results[0].id, "3215462")
    }

    func testLoadProductDetail_whenFails_doesNotPublishProductDetail() {
        creator.mockProductService().isFindProductDetailRequestSuccess = false
        resetCollectors()

        let expectation = self.expectation(description: "")
        viewModel.loadProductDetail()
            .subscribe(onError: { error in
                expectation.fulfill()
            }, onCompleted: {
                expectation.fulfill()
            }).disposed(by: disposeBag)
        wait(for: [expectation], timeout: Constants.timeout)

        XCTAssertTrue(publishProductDetailCollector.results.isEmpty)
    }

    private func resetCollectors() {
        isLoadingCollector.removeAll()
        reloadImageUrlsCollector.removeAll()
        reloadFeaturesCollector.removeAll()
        publishProductDetailCollector.removeAll()
    }

}
