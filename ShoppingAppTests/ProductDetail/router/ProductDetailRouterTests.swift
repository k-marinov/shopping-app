import XCTest

@testable import ShoppingApp

class ProductDetailRouterTests: XCTestCase {

    private let creator: MockComponentCreator = MockComponentCreator.buildAllMocks()

    func testShowProductDetail_returnsFirstChildAsProductsViewController() {
        let router: ProductDetailRouter = ProductDetailRouter()
        let product: ProductResource = ProductMother.createProducts().products[0]
        let window: UIWindow = setUpWindow()
        router.showProductDetail(componentCreatable: creator, product: product, animated: false)

        XCTAssertTrue(window.rootViewController is UINavigationController)
        let viewController = (window.rootViewController as? UINavigationController)?.childViewControllers[0]
        XCTAssertTrue(viewController is ProductDetailViewController)
    }

    private func setUpWindow() -> UIWindow {
        let window: UIWindow = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        UIApplication.shared.windows[0].rootViewController = UINavigationController()
        return window
    }

}
