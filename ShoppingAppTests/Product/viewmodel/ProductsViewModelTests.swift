import XCTest
import RxSwift

@testable import ShoppingApp

class ProductsViewModelTests: XCTestCase {

    let disposeBag: DisposeBag = DisposeBag()
    let creator: MockComponentCreator = MockComponentCreator.buildAllMocks()
    var viewModel: ProductsViewModel!
    var isLoadingCollector: RxCollector<Bool>!
    var reloadDataCollector: RxCollector<Int>!

    override func setUp() {
        super.setUp()
        viewModel = ProductsViewModel(componentCreatable: creator)
        isLoadingCollector = RxCollector<Bool>().collect(from: viewModel.isLoading.asObservable())
        reloadDataCollector = RxCollector<Int>().collect(from: viewModel.reloadData.asObservable())
    }

    func testLoadProducts_whenProductsAreReturnedWithSuccess_updatesUi() {
        creator.mockProductService().isRequestSuccess = true
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
        creator.mockProductService().isRequestSuccess = true

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
        creator.mockProductService().isRequestSuccess = false
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

    private func resetCollectors() {
        isLoadingCollector.removeAll()
        reloadDataCollector.removeAll()
    }

}
