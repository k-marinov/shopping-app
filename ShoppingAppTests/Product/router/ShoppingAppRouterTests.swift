
import XCTest

@testable import ShoppingApp

class ShoppingAppRouterTests: XCTestCase {

    let creator: MockComponentCreator = MockComponentCreator.buildAllMocks()
    var viewModel: ProductsViewModel!
    var isLoadingCollector: RxCollector<Bool>!
    var reloadDataCollector: RxCollector<Void>!

    func testSetRootViewController_returnsUINavigationControllerAsRoot() {
        let router: ShoppingAppRouter = ShoppingAppRouter(componentCreatable: creator)
        let window = router.setRootViewController(
            to: UIWindow(frame: CGRect(x: 0, y: 0, width: 320, height: 640)),
            componentCreatable: ComponentCreator())
        XCTAssertTrue(window.rootViewController is UINavigationController)
    }

    func testSetRootViewController_returnsFirstChildAsProductsViewController() {
        let router: ShoppingAppRouter = ShoppingAppRouter(componentCreatable: creator)
        let window = router.setRootViewController(
            to: UIWindow(frame: CGRect(x: 0, y: 0, width: 320, height: 640)),
            componentCreatable: ComponentCreator())
        let viewController: UIViewController? = (window.rootViewController as? UINavigationController)?
            .childViewControllers[0]
        XCTAssertTrue(viewController is ProductsViewController)
    }

}
