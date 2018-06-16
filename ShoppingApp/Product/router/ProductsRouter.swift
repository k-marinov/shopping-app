import UIKit

class ProductsRouter: ViewControllerCreatable, Navigation {

    required init(componentCreatable: ComponentCreatable) {
    }

    func setProductsViewControllerAsRoot(to window: UIWindow, componentCreatable: ComponentCreatable) -> UIWindow {
        let viewController: UIViewController = createViewController(
            withViewModel: ProductsViewModel(componentCreatable: componentCreatable),
            viewControllerType: ProductsViewController.self)
        window.rootViewController = rootNavigationController(rootViewController: viewController)
        window.makeKeyAndVisible()
        return window
    }

    private func rootNavigationController(rootViewController: UIViewController) -> UINavigationController {
        let navigationController: UINavigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.navigationBar.tintColor = UIColor.gray
        navigationController.navigationBar.isTranslucent = true
        navigationController.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.gray]
        return navigationController
    }

}
