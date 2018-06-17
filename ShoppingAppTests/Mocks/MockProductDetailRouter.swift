import UIKit

@testable import ShoppingApp

class MockProductDetailRouter: ProductDetailRouter {

    var isShowProductDetailCalled = false

    override func showProductDetail(componentCreatable: ComponentCreatable, product: ProductResource, animated: Bool) {
        isShowProductDetailCalled = true
    }

}
