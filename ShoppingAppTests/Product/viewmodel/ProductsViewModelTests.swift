import XCTest
import RxSwift

@testable import ShoppingApp

class ProductsViewModelTests: XCTestCase {

    let disposeBag: DisposeBag = DisposeBag()
    let creator: MockComponentCreator = MockComponentCreator.buildAllMocks()
    var viewModel: ProductsViewModel!
    var isLoadingCollector: RxCollector<Bool>!
    var reloadDataCollector: RxCollector<Void>!

    override func setUp() {
        super.setUp()
        viewModel = ProductsViewModel(componentCreatable: creator)
    }

    func testLoadProducts_whenProductsAreReturnedWithSuccess_updatesUi() {
        
    }

    private func resetCollectors() {
        isLoadingCollector = RxCollector<Bool>().collect(from: viewModel.isLoading.asObservable())
        reloadDataCollector = RxCollector<Void>().collect(from: viewModel.reloadData.asObservable())
    }

}
