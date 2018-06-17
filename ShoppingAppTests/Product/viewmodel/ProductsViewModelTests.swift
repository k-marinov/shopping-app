import XCTest
import RxSwift

@testable import ShoppingApp

class ProductsViewModelTests: XCTestCase {

    let disposeBag: DisposeBag = DisposeBag()
    let creator: MockComponentCreator = MockComponentCreator.buildAllMocks()
    var viewModel: ProductsViewModel!
    var isLoadingCollector: RxCollector<Bool>!
    var reloadDataCollector: RxCollector<Int>!
    var collectionView: UICollectionView!

    override func setUp() {
        super.setUp()
        viewModel = ProductsViewModel(componentCreatable: creator)
        isLoadingCollector = RxCollector<Bool>().collect(from: viewModel.isLoading.asObservable())
        reloadDataCollector = RxCollector<Int>().collect(from: viewModel.reloadData.asObservable())
    }

    func testLoadProducts_whenProductsAreReturnedWithSuccess_updatesUi() {
        creator.mockProductService().isFindAllProductsRequestSuccess = true
        resetCollectors()

        let expectation = self.expectation(description: "")
        viewModel.loadProducts()
            .subscribe(onError: { error in
                expectation.fulfill()
            }, onCompleted: {
                expectation.fulfill()
            }).disposed(by: disposeBag)
        wait(for: [expectation], timeout: Constants.timeout)

        XCTAssertFalse(isLoadingCollector.results.isEmpty)
        XCTAssertEqual(isLoadingCollector.results, [true, false])
        XCTAssertEqual(reloadDataCollector.results.count, 1)
        XCTAssertEqual(reloadDataCollector.results[0], 3)
    }

    func testLoadProducts_whenProductsAreReturnedWithSuccess_appendsOnceDataSource() {
        creator.mockProductService().isFindAllProductsRequestSuccess = true

        let expectation = self.expectation(description: "")
        viewModel.loadProducts()
            .subscribe(onError: { error in
                expectation.fulfill()
            }, onCompleted: {
                expectation.fulfill()
            }).disposed(by: disposeBag)
        wait(for: [expectation], timeout: Constants.timeout)

        XCTAssertEqual(viewModel.dataSource.count(), 3)
    }

    func testLoadProducts_whenProductsNotReturned_updatesUi() {
        creator.mockProductService().isFindAllProductsRequestSuccess = false
        resetCollectors()

        let expectation = self.expectation(description: "")
        viewModel.loadProducts()
            .subscribe(onError: { error in
                expectation.fulfill()
            }, onCompleted: {
                expectation.fulfill()
            }).disposed(by: disposeBag)
        wait(for: [expectation], timeout: Constants.timeout)

        XCTAssertFalse(isLoadingCollector.results.isEmpty)
        XCTAssertEqual(isLoadingCollector.results, [true, false])
        XCTAssertEqual(reloadDataCollector.results.count, 0)
    }

    func testDidSelectItem_whenHasProductAtGivenIndexPath_navigatesToProductDetail() {
        let products: [ProductResource] = ProductMother.createProducts().products
        let indexPath: IndexPath = IndexPath(row: 0, section: 0)
        viewModel.dataSource.appendOnce(contentsOf: products)
        viewModel.delegate.collectionView(collectionView(dataSource: viewModel.dataSource), didSelectItemAt: indexPath)

        XCTAssertTrue(creator.mockProductDetailRouter().isShowProductDetailCalled)
    }

    private func collectionView(dataSource: CollectionViewDataSource<ProductResource, ProductCell>) -> UICollectionView {
        let frame: CGRect = CGRect(x: 0, y: 0, width: 1256, height: 2560)
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: UICollectionViewFlowLayout.init())
        collectionView.registerCellNib(with: ProductCell.identifier)
        collectionView.dataSource = viewModel.dataSource
        collectionView.delegate = viewModel.delegate
        collectionView.reloadData()
        return collectionView
    }

    private func resetCollectors() {
        isLoadingCollector.removeAll()
        reloadDataCollector.removeAll()
    }

}
