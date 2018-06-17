import UIKit

class ProductsRouter: ViewControllerCreatable, Navigation {

    func productsViewController(_ componentCreatable: ComponentCreatable) -> ProductsViewController {
        return createViewController(
            with: ProductsViewModel(componentCreatable: componentCreatable),
            viewControllerType: ProductsViewController.self) as! ProductsViewController
    }

}
