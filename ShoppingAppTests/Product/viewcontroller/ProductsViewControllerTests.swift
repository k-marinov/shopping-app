import XCTest
import RxSwift

@testable import ShoppingApp

class ProductsViewControllerTests: XCTestCase, ViewControllerCreatable {

    let disposeBag: DisposeBag = DisposeBag()
    let creator: MockComponentCreator = MockComponentCreator.buildAllMocks()
    var viewController: ProductsViewController!

    func testViewDidLoad_whenViewControllerIsLoaded_loadsProducts() {
        creator.mockProductService().isFindAllProductsRequestSuccess = true
        viewController = productsViewController()

        let expectation = self.expectation(description: "")
        viewController.productsViewModel.reloadData.subscribe(onNext: { _ in
            expectation.fulfill()
        }, onError: { _ in
            expectation.fulfill()
        }, onCompleted: {
            expectation.fulfill()
        }).disposed(by: disposeBag)
        _ = viewController.view
        wait(for: [expectation], timeout: Constants.timeout)

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
        return createViewController(
            with: ProductsViewModel(componentCreatable: creator),
            viewControllerType: ProductsViewController.self)
            as! ProductsViewController
    }

}
