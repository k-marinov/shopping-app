import XCTest
import RxSwift

@testable import ShoppingApp

class ProductsViewControllerTests: XCTestCase, ViewControllerCreatable {

    let disposeBag: DisposeBag = DisposeBag()
    let creator: MockComponentCreator = MockComponentCreator.buildAllMocks()
    var viewModel: ProductsViewModel!
    var viewController: ProductsViewController!

    override func setUp() {
        super.setUp()
        viewModel = ProductsViewModel(componentCreatable: creator)
    }

    func testViewDidLoad_whenViewControllerIsLoaded_loadsProducts() {
        creator.mockProductService().isFindAllProductsRequestSuccess = true
        viewController = productsViewController()
        _ = viewController.view

        XCTAssertEqual(viewController.collectionView.numberOfItems(inSection: 0), 3)
    }

    func testViewDidLoad_whenViewControllerIsLoaded_setsUpCollectionViewDataSourceAndDelegate() {
        creator.mockProductService().isFindAllProductsRequestSuccess = true
        viewController = productsViewController()
        _ = viewController.view

        XCTAssertNotNil(viewController.collectionView.dataSource)
        XCTAssertNotNil(viewController.collectionView.delegate)
    }

    private func productsViewController() -> ProductsViewController {
        return createViewController(with: viewModel, viewControllerType: ProductsViewController.self)
            as! ProductsViewController
    }

}
