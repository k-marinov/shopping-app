import UIKit

class ProductDetailRouter: ViewControllerCreatable, Navigation {

    func showProductDetail(
        componentCreatable: ComponentCreatable,
        product: ProductResource,
        animated: Bool = true) {
        let viewController: ProductDetailViewController = createViewController(
            with: ProductDetailViewModel(componentCreatable: componentCreatable, product: product),
            viewControllerType: ProductDetailViewController.self) as! ProductDetailViewController

        navigationController()?.pushViewController(viewController, animated: animated)
    }

}
