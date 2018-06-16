import UIKit

class ShoppingAppRouter: ViewControllerCreatable, Navigation {

    private let productsRouter: ProductsRouter

    required init(componentCreatable: ComponentCreatable) {
        productsRouter = componentCreatable.create(with: componentCreatable)
    }

    func setRootViewController(to window: UIWindow, componentCreatable: ComponentCreatable) -> UIWindow {
        return productsRouter.setProductsViewControllerAsRoot(to: window, componentCreatable:componentCreatable)
    }

}
