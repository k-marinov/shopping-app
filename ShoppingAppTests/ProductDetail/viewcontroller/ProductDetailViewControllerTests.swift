import XCTest
import RxSwift

@testable import ShoppingApp

class ProductDetailViewControllerTests: XCTestCase, ViewControllerCreatable {

    let disposeBag: DisposeBag = DisposeBag()
    let creator: MockComponentCreator = MockComponentCreator.buildAllMocks()
    var viewController: ProductDetailViewController!
    let product = ProductResource(json: ProductMother.product3215462Json())

    func testViewDidLoad_whenViewControllerIsLoaded_setsUpProductDetail() {
        creator.mockProductService().isFindProductDetailRequestSuccess = true
        viewController = productDetailViewController()
        _ = viewController.view

        let expectation = self.expectation(description: "")
        viewController.productDetailViewModel
            .isLoading
            .subscribe(onNext: { _ in
                expectation.fulfill()
            }, onError: { _ in
                expectation.fulfill()
            }).disposed(by: disposeBag)
        wait(for: [expectation], timeout: Constants.timeout)

        XCTAssertEqual(viewController.tableView.numberOfRows(inSection: 0), 4)
        XCTAssertEqual(viewController.collectionView.numberOfItems(inSection: 0), 4)
        XCTAssertEqual(viewController.priceLabel.text, "£349.00")
        XCTAssertEqual(viewController.specialOfferLabel.text, "buy 1 free get 1 free")
        XCTAssertEqual(viewController.additionalServicesLabel.text, "2 year guarantee included, 1 month free service")
        XCTAssertEqual(viewController.informationLabel.attributedText, NSAttributedString(html: product.information()))
        XCTAssertEqual(viewController.codeLabel.text, "Product code: 81701107")
    }

    private func productDetailViewController() -> ProductDetailViewController {

        return createViewController(
            with: ProductDetailViewModel(componentCreatable: creator, product: product),
            viewControllerType: ProductDetailViewController.self)
            as! ProductDetailViewController
    }

}
