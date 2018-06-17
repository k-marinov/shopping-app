import UIKit

class ShoppingAppRouter: ViewControllerCreatable, Navigation {

    private let productsRouter: ProductsRouter

    required init(componentCreatable: ComponentCreatable) {
        productsRouter = componentCreatable.create(with: componentCreatable)
    }

    func setRootViewController(to window: UIWindow, componentCreatable: ComponentCreatable) -> UIWindow {
        let viewController: ProductsViewController = productsRouter
            .productsViewController(componentCreatable: componentCreatable)
        window.rootViewController = rootNavigationController(rootViewController: viewController)
        window.makeKeyAndVisible()
        return window
    }

    private func rootNavigationController(rootViewController: UIViewController) -> UINavigationController {
        let controller: UINavigationController = UINavigationController(rootViewController: rootViewController)
        controller.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.gray]
        controller.navigationBar.tintColor = UIColor.gray
        return controller
    }

}
