import UIKit

class ProductsRouter: ViewControllerCreatable, Navigation {

    required init(componentCreatable: ComponentCreatable) {
    }

    func productsViewController(componentCreatable: ComponentCreatable) -> ProductsViewController {
        return createViewController(
            with: ProductsViewModel(componentCreatable: componentCreatable),
            viewControllerType: ProductsViewController.self) as! ProductsViewController
    }

}
